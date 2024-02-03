Return-Path: <linux-kernel+bounces-51278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A85A8488A0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997781C22051
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F675FBBC;
	Sat,  3 Feb 2024 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2riJEf6"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5175EE68
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 19:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706990135; cv=none; b=KBpmu7fFrhZuKEtE0QSHjHrtjLL2lYuTIlvLjZAWSFqqdut84hh5zf9HXMTJ6+T0zUWgtRzpkDB6KdmKSCicRdS67mLrCTqEj+hs8BSPwLrG3k054D8Keyn5/8eVfSoiUdInnIkPPRexntz5en8MXqFfFKq1htUtN0CQgBiQylw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706990135; c=relaxed/simple;
	bh=XHvMjT6sPY3NTHcPmQA0vryOKP2XSLE2suiccvQg9wE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dMnELhQSBusDjBIBjUhRWt1CVQFvvgmX+uRjiMY2lDzWyrUORk28ak7aoOI6dFTu6V2DU5jmE4JGezq32L46eTBjbabOh1ZALJiLKTpZwLpbLQvvEQeq5DYZWjilMosxrhGhmRCE7CW4B5VxAYI+7mCz9RpmyiJSRKlMsdzsseA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2riJEf6; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-363ac28b375so6914985ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 11:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706990133; x=1707594933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5sFMyFsZOm+ODvmdcqDqnNfPw5aI2/9OocYowkg3fU0=;
        b=c2riJEf6QjNoijW1vRM9Yt26vAW+HgF4ArLkZYCy1+wjd9OwaG9LUimDQrHur4g7Hf
         TRseILoABM2MzrXDdw6m/hdIr4j8a7OyDBUPfsMr/gZV1+RS4Kb01073LqQqYZgzQCr2
         zJXJdJOWPi4VW5LX+RIoO24yScqICZbWJwbxviFBGworFoyGCoUglJ5wGWxcIbomJ080
         +/lEz67ZgGhJMFW5PeyFAMW/yAKin2Oy1hUra27joQhcoa3egjyvwJGiXswye/7Kqu20
         mJanlVD+/kJ2x6fwGlYmj5GfaV1WHxDSpVrTglnIKEkL0cifr2pPh7UfF8H/eh8X/Fsl
         4lkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706990133; x=1707594933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5sFMyFsZOm+ODvmdcqDqnNfPw5aI2/9OocYowkg3fU0=;
        b=q0ZsjHYqaZZqnZSX9Rec1uTLgkiFPHQHLKe/ACJbaxYvrjQvF2YeVMVTgJ4zhhh53k
         tACzI/yqXi4WgsS5gep+cTt2htn+lQ3yU9D5or8SoYPpVkNMKmrc9Mz+9qtTW/yzYh4N
         CucAqKh7BViF+NgQFEY362tagQt1ENR8sonPliHi8x0kluqQoyM/4LyZNx6RJufNFUrZ
         djHmLMJ35DrJ1tKF1DJxvhVkd0EPWXHHE6YHbruuMHGFeThP9jcIcIzXxEEX4F0J8cY+
         Q+IV19UvrGMZ3YyhrZhnbYjSrOUDpxYZ5bYMeFlUS+PUgm+GRMyHDeWfXL6hdzhhsYp/
         LVmA==
X-Gm-Message-State: AOJu0YyY5VA3GhewvaNMq7oo7aiCLbLt63EAhfcdS9XdGbTKzj0lxoyt
	JIRBzxv5I0hTEj+0LliONA0C3agdvfLzD3kjS+YhX3eBjljq4hKQ5LPU4us0
X-Google-Smtp-Source: AGHT+IHgq787YPrXHrxEioTIvUhvOtvNHW6DOlhc1o3/JBeM8b14WbicmZP2JqoqHUq46JjuLrEvBg==
X-Received: by 2002:a92:c5ce:0:b0:363:6da9:2bc3 with SMTP id s14-20020a92c5ce000000b003636da92bc3mr5533234ilt.11.1706990133082;
        Sat, 03 Feb 2024 11:55:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUePlp0ivLh07xjFatzJ1LeDHvlhZT9okl13oJu65ThfD8E/kAteSIci0SbqkLhSkRdIZz8hKhA88m4d68OcuLcQzfmqX6er1SjlppO5xgEUvHjiy72K4IwJ8sQqROY
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id bd1-20020a056e02300100b003639075ae9asm1417232ilb.63.2024.02.03.11.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 11:55:32 -0800 (PST)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	akpm@linuxfoundation.org
Cc: joe@perches.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 0/2] checkpatch: relax >75 warning, adjust report format
Date: Sat,  3 Feb 2024 12:55:25 -0700
Message-ID: <20240203195527.212505-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. current checkpatch warns: "Prefer a maximum 75 chars per line"
on [1]:

[1] https://lore.kernel.org/lkml/20200825153338.17061-1-vincent.whitchurch@axis.com

That is overly strict.  Instead allow long non-whitespace strings
(\S+) to exceed 75 chars, after tolerating \s in 1st 10 chars.

This is more permissive than the current Fixes/link detector (which I
preserved), IMHO checkpatch shouldn't be that fussy; it doesn't verify
URLs either.

2. adjust report format for nicer pararaphs.

Current checkpatch format uses -------------- lines to segment the
many per-patch reports, but then inserts a blank line just above the
last per-patch report line, breaking the paragraph nature of that
report.

Move the blank line down, which places it just above the -------- line
starting the next per-patch report.  Also wrap the per-patch summary
line, so its columnar position is independent of the patch-name (and
its length), and so your terminal window doesn't have to wrap the
line.  This makes the report easier to visually scroll/scan, since the
status is always in the same column.

IOW, from this:

0001-checkpatch-report last line, looks part of 0002
--------------------------------------------------------------
0002-checkpatch-minor-whitespace-changes-for-readability.patch
--------------------------------------------------------------
total: 0 errors, 0 warnings, 15 lines checked

0002-checkpatch-minor-whitespace-changes-for-readability.patch has ....
-------------------------------------------------
next-patch ...

To this:

--------------------------------------------------------------
0002-checkpatch-minor-whitespace-changes-for-readability.patch
--------------------------------------------------------------
total: 0 errors, 0 warnings, 15 lines checked
0002-checkpatch-minor-whitespace-changes-for-readability.patch 
 has no obvious style problems and is ready for submission.

-------------------------------------------------
next-patch ...

Jim Cromie (2):
  checkpatch: tolerate long lines w/o spaces
  checkpatch: minor whitespace changes for readability

 scripts/checkpatch.pl | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.43.0


