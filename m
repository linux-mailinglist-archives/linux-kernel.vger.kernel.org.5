Return-Path: <linux-kernel+bounces-110865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E79D8864EE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A589DB22722
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D27515BB;
	Fri, 22 Mar 2024 01:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYENYrwf"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19E910E3;
	Fri, 22 Mar 2024 01:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711072568; cv=none; b=FDt57KcDvwYcZ6UsKO5169Lhlm3NloX6yIaA2nF5GDU8YxOznajUtG+X/xf+2pe8MVqAaUO56F2G7fowatBYe6r2oqZpqE9lVc4Laxc7T2gJo/LOZbgN1wAsTA1cOcH6ygq/+0V/HaGcZh7ZTQSBC292ysFbNQwZ/bbq7k0kgdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711072568; c=relaxed/simple;
	bh=RMKkVWlMi3qpcXxfdqH8qCZEDuD5oSIGYu4ULjWoV+w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sgPcO5gn+r9cI12ZaE97dGOoGe8lrDfW2pqZepWJV2Bpvws1vC9HdiIt5Bue1yddvqShHxY1fQfWnRyG7Eet2oLLYkbMNSYkUPprogK9bv36kKCYD/7Dirm0ps0N2OD4fCmy3dfbBGZu/Jysn8eM+oYtNnLhutQsJPLA7Pf0FxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYENYrwf; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513dc99b709so2088626e87.1;
        Thu, 21 Mar 2024 18:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711072565; x=1711677365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bwWa4BgJJkr16k/nzdvDFnFjU1oDVg5Ayz3jjJ3bhPc=;
        b=iYENYrwf9leVJH303ga+SDdZM/zF1MUgKNWLq6HSEEDm133iYTqUUF7eCsItLtQnYl
         lMYJWk7TcWTGy86/xL7M+G4oEGdPzjmqvEbJBPC/aO/NBgn0NO2YGEUG5ebnMjEzi9us
         AQIFPsYLdkHVDctxlVEEic4kNFePg61yqNc7VadOZ4jKSsgkFiCK7gJfE46DPGXkpCKf
         XHhHvp5P5LGSyrRhKj+zvcsY+sO/nQzKhfR6MODPLo2veibe3N0j690Mkp+3B2qwdM5n
         4iDK8fDzknjUNduIjkCF+6GXZPPW7yk5WWdWGXuHGBZjfc6tiPDqHG51ugg2z43NiLZw
         9jzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711072565; x=1711677365;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bwWa4BgJJkr16k/nzdvDFnFjU1oDVg5Ayz3jjJ3bhPc=;
        b=IwyO1I6nRV/0k2TR/J8y5vm5TsP6LAOg0TxXmSTBgK/dijwGJ7E9TZHy708+5aJUqG
         i6GOAGx48iR4cSmwK+ATlkzvbgdR2OYKlFBTKWAeJXcaCuLzVA1/TBh3hVmRztaWzMq0
         dbp9FQr0dvy7F2p65WM+WWWODuc8aM5FNaw8XobjeHrUZEmCkoNtfSgEBfrb9M0ZR3LY
         51unhfJLYSQf8h7V9Q0SkSCpy7rpL0yyKN67Sx9Qliq03RCI1NQ2cGPjps9nRsmoDhUK
         YvetLWFcqxO3k5PRhPDzyd2kwnerFq1AOrw9JnldYgSuet801MWLlyLlOQBmS07Jn6AF
         QM5g==
X-Forwarded-Encrypted: i=1; AJvYcCXUmx4IL3rlgFfoOuPar1HFN7bMdXpiySqIesJC1ywJSVOCg3vN+7lUYITkk105+vvN9bHgLKGBF4q06K2Y4ypV6ye9sJ6f7BUxug==
X-Gm-Message-State: AOJu0Yx6xTsAXQs5cyAZts6oRnN7p3tmoLtGJF32tGJIDVvLLWHya+dx
	QUQEqtuIDeivlYuFiyWcC61yOXNatIl7pIrTdLbVRCLqcLKUOrJF1jRIs2S4khavs0yOJBABxJ/
	OzkWsM0eFWm5m23uX/DixUnCDTFQ=
X-Google-Smtp-Source: AGHT+IF/TqelXBddl5IJ2N+BQNQfXFVg2IpOsyaGGMvVibUEayH8FltMU6QmTnbIqWKfxUYO9eIDLUXRtoiVnhDvSl0=
X-Received: by 2002:a05:6512:285:b0:513:e375:12c1 with SMTP id
 j5-20020a056512028500b00513e37512c1mr592514lfp.41.1711072564918; Thu, 21 Mar
 2024 18:56:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Thu, 21 Mar 2024 20:55:53 -0500
Message-ID: <CAH2r5mtMVc02DmB_hw_j49o6YQSD7Jwr4tbSMuTjxX5L7ZgkVA@mail.gmail.com>
Subject: [GIT PULL] smb client fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
279d44ceb8a495d287ec563964f2ed04b0d53b0e:

  Merge tag '6.9-rc-smb3-client-fixes-part1' of
git://git.samba.org/sfrench/cifs-2.6 (2024-03-13 13:15:24 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.9-rc-smb3-client-fixes-part2

for you to fetch changes up to e56bc745fa1de77abc2ad8debc4b1b83e0426c49:

  smb311: additional compression flag defined in updated protocol spec
(2024-03-20 11:49:44 -0500)

----------------------------------------------------------------
Nine cifs.ko changesets, including three for stable
- Various get_inode_info_fixes
- Fix for querying xattrs of cached dirs
- Four minor cleanup fixes (including adding some header corrections
and a missing flag)
- Performance improvement for deferred close
- Two query interface fixes

Still working on the important fix to enable a way to handle password
rotation and testing some misc small features/fixes
----------------------------------------------------------------
Bharath SM (2):
      cifs: defer close file handles having RH lease
      cifs: remove redundant variable assignment

David Howells (1):
      cifs: Move some extern decls from .c files to .h

Eugene Korenevsky (1):
      cifs: open_cached_dir(): add FILE_READ_EA to desired access

Meetakshi Setiya (1):
      cifs: fixes for get_inode_info

Shyam Prasad N (2):
      cifs: make sure server interfaces are requested only for SMB3+
      cifs: reduce warning log level for server not advertising interfaces

Steve French (2):
      smb311: correct incorrect offset field in compression header
      smb311: additional compression flag defined in updated protocol spec

 fs/smb/client/cached_dir.c |  3 ++-
 fs/smb/client/cifsfs.c     |  4 ----
 fs/smb/client/cifsglob.h   |  5 +++++
 fs/smb/client/connect.c    |  9 +++++----
 fs/smb/client/file.c       | 20 +++++++++++++++-----
 fs/smb/client/inode.c      | 26 +++++++++++++-------------
 fs/smb/client/misc.c       |  3 ---
 fs/smb/client/sess.c       |  4 ++--
 fs/smb/client/smb2ops.c    |  2 ++
 fs/smb/client/smb2pdu.c    |  5 +++--
 fs/smb/common/smb2pdu.h    | 12 +++++++-----
 11 files changed, 54 insertions(+), 39 deletions(-)


-- 
Thanks,

Steve

