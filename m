Return-Path: <linux-kernel+bounces-107542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7294487FDE5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54211C21D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E4B3FBB9;
	Tue, 19 Mar 2024 12:57:04 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B4633981;
	Tue, 19 Mar 2024 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710853024; cv=none; b=ichqMknOoRWGN1aVok97ma2RoeKNbCto6LRhvCECMpmrToOtNZNiOlGCd2b0E1T3/eL28MVrzJC4GVecUFJSKyYRY/CgCz2+HFVGDRmIydgNE1hFE2WZO+3h4UIsUP58JHJo9jGB2sM0lKq9IdVy+CLx4pFGqbrcXXVao8EGSS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710853024; c=relaxed/simple;
	bh=aSfk12ZNC2aNib7t4Nxall7keaBK9D68QLM8bit25BI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Owomlf4LuahJPNZoI6/N/pfqf12oWVKdd6lGueXEvSED/9ganvVKvwslYqtykL9BSawSsjqSAEuw/jLuj99BEde13vfCt7FIV39AVh8VDXip7fiUQNhiOiWBaRfhugHRG23HqnqIFhSuvHue/UZ/FhrKDobckm4lJlvxmkhCVM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a4e0859b65so11141eaf.0;
        Tue, 19 Mar 2024 05:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710853022; x=1711457822;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xrj+Mt4U3wrpxTx1LRg8WME9pASH7mdtf+hRrVD3zVk=;
        b=RwOfkVYfKZ7rgoEq0oEWMHtMA0l7CPkTaeXKMUV0SIgp9OIi6KwwOOlKF40VkLV2Av
         L7IDOqxWROpXMTqBCw51/A7uKneWs7Lh96TknX207k47PPAJxrxQ7SVuSJ76EqqCuMHe
         3cazPzmb0AXJW1qFcjHsmj+KqOKmSTb8b/wju0bj7lJi64kvabxNfbNqzWZbdf6WxzQn
         ZernRQs4/6Ocl3c0ut0MIqljYpDpY42pxYrcoo3xXQvPvJLhuvHPDoxdqdgpL+mZkDPD
         rF4oIBPP5DZA2o/vlXwY/zr3sXymo+cOrTtKtWP9VJ+xU4YxRAp9vAFXbIovv9W+g9A5
         rBKA==
X-Forwarded-Encrypted: i=1; AJvYcCXTC5+MwoldrrwWVulqwmTKyph3UIgM+ra4mZABSy2lWWsNT/n9IaXw5Y9Tl83YcFM9Xcf20uz+FziDNb1VUbya3rCsl4aHYEw1Bmm24BDrbs3xABoaLJ8qibFKmkvNqGmKtEj+gE0=
X-Gm-Message-State: AOJu0YwJbZTlHNHVGUVPPMsUmEOdOCRkUBoTH+GnzqtL+0UixljLTE92
	4JnGO+MYMehZ+tTfkBKONTV6EYYihiNV+g0Xc8SmXtY8XOo8atORlNdqMIXveMrvB5GREtO+l7T
	CoNT6GHvL71WXKHcR1+FmabjrlzqdpNjjMu8=
X-Google-Smtp-Source: AGHT+IF8bfM4Rz54Mt6OBW3mcF/C6DrIiYAWJme3QWHlB/fRqsPE1nkTuiRvYUjbum8eMWZWhDZfTvRy6RuVeKPuE3s=
X-Received: by 2002:a05:6870:888c:b0:221:cb1b:cc05 with SMTP id
 m12-20020a056870888c00b00221cb1bcc05mr2340095oam.0.1710853022246; Tue, 19 Mar
 2024 05:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Mar 2024 13:56:51 +0100
Message-ID: <CAJZ5v0hMT+x=axU2BKz5XHYwdYZzdSm-itYvYD0K16T5NUnuyw@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v6.9-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.9-rc1-2

with top-most commit a873add22a46beec0291c5a40194a90eb92ba3da

 Merge branch 'acpi-docs'

on top of commit 943446795909929f261565cebafb3b56d66cc513

 Merge tag 'acpi-6.9-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more ACPI updates for 6.9-rc1.

These update ACPI documentation and kerneldoc comments.

Specifics:

 - Add markup to generate links from footnotes in the ACPI enumeration
   document (Chris Packham).

 - Update the handle_eject_request() kerneldoc comment to document the
   arguments of the function and improve kerneldoc comments for ACPI
   suspend and hibernation functions (Yang Li).

Thanks!


---------------

Chris Packham (1):
      ACPI: docs: enumeration: Make footnotes links

Yang Li (2):
      ACPI: Document handle_eject_request() arguments
      ACPI: PM: Improve kerneldoc comments for suspend and hibernation functions

---------------

 Documentation/firmware-guide/acpi/enumeration.rst | 12 ++++++------
 drivers/acpi/dock.c                               |  2 ++
 drivers/acpi/sleep.c                              | 24 +++++++++++++----------
 3 files changed, 22 insertions(+), 16 deletions(-)

