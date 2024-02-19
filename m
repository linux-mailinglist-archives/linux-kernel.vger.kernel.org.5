Return-Path: <linux-kernel+bounces-71653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B545285A877
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550061F21C40
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBFF3C467;
	Mon, 19 Feb 2024 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.ch header.i=flurry123@gmx.ch header.b="UgSCrXAR"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFDD38F96;
	Mon, 19 Feb 2024 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359210; cv=none; b=PpbonuL/ZS4XGnEzDtLjhTxXjTO3EHgT9adGxblgrf4DCISTgg8EQ4P3+VYACb4EVs6O1LBur2m45vU8+UQ0P5yWpAE3ce4LVd69jYtpX9iVMnhGhJhZeLRJhWiC538Gemd2rNIQ4iFOf5wfddC4ciNaayKkUib4j1d5IudI2Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359210; c=relaxed/simple;
	bh=OH4defjKQkatPG8aw0BIrccIFTqxTSBkv6smamyXyvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Am4dVbpU3mCumUS8/N0KJq9vdSXrnWPIJxwQ8yrthBaaKwLK46CJCrm0pA13o/qJOiq7JE2gBrAmAcpGQFctLfY6I7BenPn0OclsxyFyK5lZ/iaJKMbm0ALShZkrJ9H+f1UdHsXCWXpTZwMbdRfsA4dUM+iqmEWYUUGbagTtpbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.ch; spf=pass smtp.mailfrom=gmx.ch; dkim=pass (2048-bit key) header.d=gmx.ch header.i=flurry123@gmx.ch header.b=UgSCrXAR; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.ch; s=s31663417;
	t=1708359204; x=1708964004; i=flurry123@gmx.ch;
	bh=OH4defjKQkatPG8aw0BIrccIFTqxTSBkv6smamyXyvE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=UgSCrXARyDtCjcLwLOEBCrWLBbuDXfrND6h7YF3K3a7Nsk7GXh9xOcsZN10LGlA0
	 egp1Qyg5BTUQdEJxvqIgysXdXaVs9uBCUXhofMJL6SyiLS0T9TL4qwoiRyExNAFxM
	 n28G+IS2tcI29ljqudBSn5X3QRC+gSE3XdxyGfzp7c++qRYUg1l3iCLvYm9IH06Ex
	 N7ThlKGvdnBgxvNq+QlGGMTdpcLQJuwcDNJxexxAgB/CPuXxkQ3cUwUsfvF+wMeGM
	 ItZI0SPbvPt4DsFNhQ0ONLM3eF8pVVBQaHgwUFaUhr8LqLMyxmZPGyxaYfz0DZRvL
	 +Q9DAnyU3JNP6s5ASA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from void.speedport.ip ([84.155.142.60]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MV63g-1rTk142xtu-00S9Jl; Mon, 19
 Feb 2024 17:13:24 +0100
From: Hans Peter <flurry123@gmx.ch>
To: tiwai@suse.de
Cc: flurry123@gmx.ch,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	tiwai@suse.com
Subject: RE: [PATCH] ALSA: hda/realtek: Enable Mute LED on HP 840 G8 (MB 8AB8) 
Date: Mon, 19 Feb 2024 17:00:57 +0100
Message-ID: <20240219161240.3840-1-flurry123@gmx.ch>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <874je4q2h0.wl-tiwai@suse.de>
References: <874je4q2h0.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ui8y0rdL7UK2PJ9aPEMQnaEFvD1Pp1UGVqnNh/NHu2PQ9v/8j/Y
 HjHV7LjCuWs9WPuHwEdigcjZ7kfYeW9BpEp+rXMUx2ofoaR64uHPXVOVNLmLwlRmex0i5sd
 YoMhMHAYsKk3k15a1SQYgriictU0eCWAYfItQjFi6/3l+CH72mN3eOWu4ZkXTJn5NlFARNm
 Shh5n9cYbwshNRZvGP/Ew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:acXfCcZT+3A=;j1CvMKjM4MMwZq73kt0BvvHvLPA
 t9iKJA3KV5L0F5LDSM5XqwODh1UfmRbkirRRLyYpY9fXgWc0iv7sVqvZHNtwo+iUt6w1DcUWc
 lwz10DAW2jkUbjLIi/gHeT1fXOkSu8OghCHhJjMZGdsK84rvW4WYCH7O4xW9BBaBdZ1u3oqP6
 BeDBAk/W3pylXJFl2xNXr8uRDi16AH7XU9dKDEP/EH8s3ZfLkqtQVtZc3SEYOUyhuKkXK9Ocp
 QVhuIx0H9wsiVrXbgf1KP/AJbbygn0iX3X3ng4n9RW/L+baem1XhVUhpQLfC2YSJhzRCWqnlj
 yZL2YgtkPklU99ksgAVYMh99TlYucpPbP8xDLKY+/JZ0yju5r/IeHamid/mUsqurnDbGdnnYW
 doT+jwWjvnDX+Kku1wjlivdUmT/+Y/FEEoBJfWtjRVT/CF/njyR4VUlWzNlLfzACKYAJUJWDl
 a0nj14yri/G5E6tYbwM9qxEbnkLokLrU1j8ZjhAI88RA4vfVXC2ic1PHa+YIFtqisLPcB/jWP
 xdDs6ic6rCetrR1DkHHBfxTrp84inqsna5TYFNjgd0pExPFwMo0ianrBRTyVVQMouMQAit6Fa
 mLTOjYtPHoCrgXgxhxOv4XYHG+xPscH4oa7C1DmoVjwmOBNcMv95EwdaNhcv8tGdc0Aaw2+2k
 S0szbt6ppfA/E9EP7h+MwWatK6HKEqVbQfyv6GxV2MxHxkJoT35hf9x70Wp3fDFbOZBgnWd/s
 mnATF4KBnmz+uELEGyS4GA/HqfreUMO9Veq04FSRwD6gewbjNpHi2H08dIWK4pMRc1tiDk1+q
 iilxYnIyxuo3Of5eGnNZilwMvK8xMyvgpuQ1lWdoDCoBY=

I apologize, this is my first patch ever.

On my HP EliteBook 840 G8 Notebook PC (ProdId 5S7R6EC#ABD, built 2022 for
german market) the Mute LED ist always on. The mute button itself works as
expected. alsa-info.sh shows a different subsystem-id 0x8ab9 for Realtek
ALC285 Codec, thus the existing quirks for HP 840 G8 don't work.
Therefore, add a new quirk for this type of EliteBook.

Signed-off-by: Hans Peter <flurry123@gmx.ch>
=2D--
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0ec1312bffd5..26a90c92c3b8 100644
=2D-- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9927,6 +9927,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[]=
 =3D {
 	SND_PCI_QUIRK(0x103c, 0x8aa3, "HP ProBook 450 G9 (MB 8AA1)", ALC236_FIXU=
P_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8aa8, "HP EliteBook 640 G9 (MB 8AA6)", ALC236_FI=
XUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8aab, "HP EliteBook 650 G9 (MB 8AA9)", ALC236_FI=
XUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8ab9, "HP EliteBook 840 G8 (MB 8AB8)", ALC285_FI=
XUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8abb, "HP ZBook Firefly 14 G9", ALC245_FIXUP_CS3=
5L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ad1, "HP EliteBook 840 14 inch G9 Notebook PC",=
 ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ad2, "HP EliteBook 860 16 inch G9 Notebook PC",=
 ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
=2D-
2.43.2


