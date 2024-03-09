Return-Path: <linux-kernel+bounces-98024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5618773C9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 21:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A7F1F21A24
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 20:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF8D4EB4C;
	Sat,  9 Mar 2024 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="GcELflsL"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082E34D9EC;
	Sat,  9 Mar 2024 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710015212; cv=none; b=DiEizPQD1CI+VzZafhonK8G/lecAqli9jyyzoYfgb4N3QJh9E95DrNLP6ZL9N15Q8dP7+chf5YlQg47jcfssc+deCdE7h0VNo3kMM1DCJ0g4UnG8FqHaGA03fhK1/z681wEe4RE/ujqX8r2FpghnYP3bkxVcea+8FrZCTZEoCK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710015212; c=relaxed/simple;
	bh=DDC1CBqfrgPh109rJsO3aoCX8S+FPW2MUiqgY2AF9rM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qS1ifmHMv1HHhtfmx73h8Y/J2iXhoPoseEpZp9xKavthNPyMwCju/SSIGlSn7EAGItFaxBXdTH1ZNRWHl7TAx1CZMUno6ygTMIbkCgUMnPDMHeUZ0D9wizv3uMunckQY2TdBYLRtGzD+6OQDQa9D/v5oCxhikRd7aoRoYmXYIL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=GcELflsL; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1710015203; x=1710620003; i=w_armin@gmx.de;
	bh=DDC1CBqfrgPh109rJsO3aoCX8S+FPW2MUiqgY2AF9rM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=GcELflsLOy5f67IKtlHLrqz3LZ4eyiVuk32fZJQjgWCfQAPRG53HNIDlwzdVvoic
	 o9FeByXfZiX80d+nUvLN3iLtM86wwYIBIWQgr1q2+BTzrMZ8qEUwsOu04SmDnWIi8
	 VbUEPdy8me30uj9z1A5KG/7T8bw3ZnDGeMT/QE248EV6F9xEqTBO7yfoCTHIkZwaW
	 U1XT8WTTvpB+F0RWkr2lc/W82L0cT3hAJjXA+4QgN6zyU7ek4QCXSrkHwKCH9Eo2Z
	 YYpIeIu+Tv0JawfL5ZYkuN4FzsDEpBjumkm+mjsz9BquumJ+ela/8FbRXyRv6yjb4
	 vPybz+7nOno14OVW3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MHGCu-1rehTn1hdQ-00DFGl; Sat, 09 Mar 2024 21:13:23 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] ACPI: bus: _OSC fixes
Date: Sat,  9 Mar 2024 21:13:05 +0100
Message-Id: <20240309201310.7548-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hcAHVwh3puWdFWCzTNLQb11Nb//DTgywMjaP/u392ecCA8J2ja6
 LkzeLC//34oOdOLMv+AwhUh1ORztMdAP1B4hD5w1gj66NX04uin6adadO6yU7emiuALkoV/
 pPk/I52liAaB+BWmRL3wrbmOCXbLbUUHrjh2Jpbg6bDhqYJ5/I1YMpYk4xWw/LG//Ab3HUq
 1vkSQ19aEQ3ZEeM8Ek+hA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:apj0qsU2eTg=;RtOeomMluZg0R4FowefKrNuIJAO
 3R1jTzdS2TisXRi/4kTc3h3dDt5ljBnHgI1FYWpEKXgpoEtI0zhf+1V/MUlhmJ3abigH2IFS8
 cc9/X4UtKsRjnyuV0ejksGrORLGHMv+GtFfWTSaarnBpBvbVqkrgV9N2MPaqrK6gJyHgyN7cu
 Zp/u3T2XeF74g6rv5zCP3MZ6YceDlRHme7oWnhOjB2Z2NvQmCk60K4VFpj43p0HgxLKcAy8Ne
 caBRThNgFhX/vI6ra0Zr7bCtC/tENwcZSvxKEEy/oGhhFa+jdm6k/mj6QajjoP+h7ZnXPxTU6
 aDYfbRMqrZ6d+6m0vGkURUwHocG00QfUke80GV1lTg3DkI61ahUyxlJTcYzzT/xBGgakyezxW
 8zAWEOH4BRwAY6K0gcWf1vKd+cbPKkHSErL4SgO+anV5Sie/7fzVLRmeSzOyAPdcoWothRYmr
 esPKocOProQEsxVMznKpawUmHT9jzd/yG7Sfpb1cqx9S5zhazRtJKN0FEdokHJxFXLxKPtF5J
 bttN2usGahuyBwUPAq4Hd1g2TpotQIkp2m2pkzwcwL1LhwbePxg999wCtMOqvYP28B/3uFqjB
 D+aPX7VgreKlOLhxqGCc7amIWOn3ZBmWHnRm/g8RxTkslGMSnWd00B3oE0PJmaBYluxOkAUtX
 rmaL2fKHt9Uc53wxfiYVCk+tmT4zrN0dn/6QotfBxjYYRoC7/Z4OeK/anHn84tvSJOyLRzjGA
 RBCHUDINI03UKQCChHh364HDQVrqQIRgrRDBfPjzb7jcFNCn6jdrLRZS9J/MHvyySHLYtZMF/
 Gzb+WAsWke+P6YzWTuZ5wdkK2CR+y77s+q/wXIhooaeis=

This patch series fixes the handling of various ACPI features bits
when evaluating _OSC.

The first three patches fix the reporting of various features supported
by the kernel, while the fourth patch corrects the feature bit used to
indicate support for the "Generic Initiator Affinity" in SRAT.

The last patch fixes the reporting of IRQ ResourceSource support. Unlike
the other feature bits, the ACPI specification states that this feature
bit might be used by the ACPI firmware to indicate whether or not it
supports the usage of IRQ ResourceSource:

	"If not set, the OS may choose to ignore the ResourceSource
	 parameter in the extended interrupt descriptor."

Since the code responsible for parsing IRQ ResourceSource already checks
if ResourceSource is present, i assumed that we can omit taking this
into account.

All patches where tested on a Asus Prime B650-Plus and a Dell Inspiron
3505.

Armin Wolf (5):
  ACPI: bus: Indicate support for _TFP thru _OSC
  ACPI: bus: Indicate support for more than 16 p-states thru _OSC
  ACPI: bus: Indicate support for the Generic Event Device thru _OSC
  ACPI: Fix Generic Initiator Affinity _OSC bit
  ACPI: bus: Indicate support for IRQ ResourceSource thru _OSC

 drivers/acpi/bus.c   | 5 +++++
 include/linux/acpi.h | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

=2D-
2.39.2


