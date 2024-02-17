Return-Path: <linux-kernel+bounces-69673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B21858D27
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 05:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AF91C21238
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 04:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E62D1C282;
	Sat, 17 Feb 2024 04:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELLerfv2"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF001B582;
	Sat, 17 Feb 2024 04:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708144125; cv=none; b=PrWxiLxV/4lSySt3It/A5TcvzCtJCw4ugifS5TMs+J9HNm2uz2B5CElx4PgQtJ/+7yYROdDqQTVPL42BANsN5MwIdgy/LpF3RNUaCy8M/+OIU/2al6ZU0bKhIkThjywZe+FhPlSSPlepnA9QTBfmIwd5lWbXdfV1tIOUzvcOwbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708144125; c=relaxed/simple;
	bh=wIKVxnG4uRsMrlDDO3NQ7o3ntBHf4wCDxpRLjLqqn6g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gz86kv36feSb5TkQY+/Bg5KxAuekzKiuAzoD2M+0KXJ1Ek2ImTMtorFpQHUXKPXeo1WhVbP1Kg0zziWHxDB4PfF1pC+47jLGigihZz0eQDM868Zp4G042Zih0y+ZPPCoJzLT5ioZrw+h3W8CaU4uQxezpqKKdIttXpCykG4A73A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELLerfv2; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d10ae127ffso35351311fa.3;
        Fri, 16 Feb 2024 20:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708144122; x=1708748922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yKYloP6oS9L/HLZXwaGbOBPZv8HXE5YWZ4rEes1rvCk=;
        b=ELLerfv2YIigWBGhNe5W2QbFmB6EkLAVB8D2CngIxJE8YbWwCSR4nq8DqhXb77cpED
         BQif5lcf0c6XsM2UVcmYSt5+G+XKfcZ7gaw8GdnMk2R3VmsWI0XC6j6zm8vQR7NEtGOI
         ditXyhxlp7vbB8zvmOqq103t8fi0QLF45u3XhKzp01fCuWlGqiYqVN4BXTvYKJWf/F/G
         Y9CpABW/GvCrEBZ4Q8W40JwM53Axt9g7jasbUzJmQ9YcovmhJNlGX04/o3EoiV++uFG3
         YcyrvBa3BmXyg/6d3Xptf5rjPuNFvu8+GUgt88tbBef7ww8zhfTrJcOiH+957TMW+SMY
         JeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708144122; x=1708748922;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yKYloP6oS9L/HLZXwaGbOBPZv8HXE5YWZ4rEes1rvCk=;
        b=MYAHuG8AcjpCyd7H08DDcBQEEH2xZFpmcLrLG0WFkg13rKneq4FpQoS8v/PqKOJoVF
         9GHHKwzWFB8CqsyYUax74tMkDTpgs2CtfkS/4ggZqxBmoczS+PAxsg36eqIG1lGoO4UC
         n/XUJGfOclbRRFWYURttXVbSccOH/ZfUVVdyLsRA5lEEU++7IbpOB9qPCPMogICdk+0M
         F+RSZlWvkms1f2Ia2bVTfXnOUMhsdjuwtPoxcbBP847dxd5d0mVCJPs+o4/6T+Epdf/4
         aoZc94wAvXP0aveYaRjswz7SgTXBPzJrd/Mu7h2vmM+kjlm8KRCo0DMPr9u2//CzPU5/
         I5Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ0d1TVLxMLluKVRpQZsawJfHdezt3NOep4lTx+A3rpfyVVKMtY6W/MnEmweUTKfyOk/NhpUY8bvchA8ALFW2/gy0hNIOnQphW/w==
X-Gm-Message-State: AOJu0YwThPs5XOW7T5EYcoH2xRfnMQz75r0LT7Z8+AKIlMR0Du67GZcL
	+ZUkJCGSqC4DhonsM7HlFRmlm2+vOz4AfQjLQGwJqea9tZ6niX/0jeXpvk3k4WR+9bvfcXZ3LY9
	Nv8CNJcuMIm4v60h4ykPlY6vWP3W5CgP+SjQooQ==
X-Google-Smtp-Source: AGHT+IGbAtVunNVTkG2JK63pgx9P0jVRF6p+tXSll7eSDALmdXi4eYjp+tT/Tys7pJusB/yelvSb8Q0jHAKj2hYIZSs=
X-Received: by 2002:a2e:be8b:0:b0:2d2:2659:a6c1 with SMTP id
 a11-20020a2ebe8b000000b002d22659a6c1mr955838ljr.33.1708144121680; Fri, 16 Feb
 2024 20:28:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Fri, 16 Feb 2024 22:28:30 -0600
Message-ID: <CAH2r5ms2_5PDfLSMJLA-_r7CtqTEchqJAToWVHV+k4WFQu9E=w@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
841c35169323cd833294798e58b9bf63fa4fa1de:

  Linux 6.8-rc4 (2024-02-11 12:18:13 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.8-rc4-smb3-client-fixes

for you to fetch changes up to 4860abb91f3d7fbaf8147d54782149bb1fc45892:

  smb: Fix regression in writes when non-standard maximum write size
negotiated (2024-02-15 22:19:23 -0600)

----------------------------------------------------------------
Five smb3 client fixes, most also for stable
- Two multichannel fixes (one to fix potential handle leak on retry)
- Work around possible serious data corruption (due to change in
folios in 6.3, for cases when non standard maximum write size
negotiated)
- Symlink creation fix
- Multiuser automount fix
----------------------------------------------------------------
Dan Carpenter (1):
      cifs: fix underflow in parse_server_interfaces()

Paulo Alcantara (2):
      smb: client: set correct id, uid and cruid for multiuser automounts
      smb: client: handle path separator of created SMB symlinks

Shyam Prasad N (1):
      cifs: update the same create_guid on replay

Steve French (1):
      smb: Fix regression in writes when non-standard maximum write
size negotiated

 fs/smb/client/cached_dir.c |  1 +
 fs/smb/client/cifsglob.h   |  1 +
 fs/smb/client/connect.c    | 14 ++++++++++++--
 fs/smb/client/fs_context.c | 11 +++++++++++
 fs/smb/client/namespace.c  | 16 ++++++++++++++++
 fs/smb/client/smb2ops.c    | 14 +++++++++++---
 fs/smb/client/smb2pdu.c    | 10 ++++++++--
 7 files changed, 60 insertions(+), 7 deletions(-)


--
Thanks,

Steve

