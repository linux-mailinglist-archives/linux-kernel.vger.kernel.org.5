Return-Path: <linux-kernel+bounces-152731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AE88AC390
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 050DAB20989
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBA517548;
	Mon, 22 Apr 2024 05:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8mF7Hzq"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EE214AB8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 05:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713762632; cv=none; b=EAkgan2oPGv7k4eOrybEahDU1dFQpuWRP+qVpWUVo3NJgr369TLze28vAF9ymwlGdCXWnZLqjY7ynMMhyB8Hqmcqsj6FwfErDvtUPuddPqdwnnMizoUJ82UHFmD6IUwg90VxbORCDKriRK3RYVGiMCagQdgvqpRE3uw2dzEZeGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713762632; c=relaxed/simple;
	bh=gvS7/ah/lRcg97Bq9dQC8MdmOWG5VzgVpprBeQwmeKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s4G6wL21Djrsne8FSHX7AuV2dsFZunI44jbYHOx1+bmuBcbIONf479kkStvo6IyJyzJL4X3kQw270EcD1s2sr9clrP9zy54WMuSt/dg7+3fBGG8V0HBaU7rXXp5SOYl1Kz7W3/wIQtKe3PIaeVDYwDW76+SmW21omijwPoxkJ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8mF7Hzq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e2c725e234so37580695ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 22:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713762630; x=1714367430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvS7/ah/lRcg97Bq9dQC8MdmOWG5VzgVpprBeQwmeKM=;
        b=Q8mF7HzqsthEQI7Zq8gQzkcpxfE3nt0leQkoGIWuL+iCb9R1Zg1bS2KqMpOs9KmRLP
         XLETsillrlOjfrhptie2V7m4NYnedviK33jCFlb7LCZbNl0wbGyE5yYIDDzOQ66OYNbz
         c20YWtPey0q81lLRI9BEkMEpOSfsTIEFvs5CeF8u0m59hggqmR2ELIjX7op+8FN//Fbi
         N+1jkA1s4LYRagFo+x3R8WLBQYF2o3jTkb7fYMEHoKWN5IMnQOsiRd4xwG044P4sEasn
         /tRpfeLz1ZpclvuYO4w608nszr6TCqABAtE0VyF4W6ai3pMMvUjvJrxEZmBSqwNhFlUy
         mr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713762630; x=1714367430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvS7/ah/lRcg97Bq9dQC8MdmOWG5VzgVpprBeQwmeKM=;
        b=dihf7gipv1OlKcesZ7crWWvrLOwusuwifVROWyNwjkY8Qo2p0WhSksJ3lWaT1VetxG
         /Q9601leFrHHkld5RnPFP+GqEG7IPCxfXxU9zAXIsYXKwypXyvkiVKT3HJ6HYwKKPrG0
         vt6C6MmZZDgrwr9/gv+fx4OTuP070r2hecZBOOyTP6y/SoOoLE5B031iSNUmZqdAcjyb
         P5A6FoK0Vz+34DQDLVwTOLPSZ6J1elL31C1hMdR0DgHNwMnhQGp61dE6wJ8r8ToBz+J7
         +70YgSWEN5PzNlVexogmOA6FhCaWG6/7t5x1SEvK59k0yHIhFKoTex5VZW4+e6MkZYRi
         L6Og==
X-Gm-Message-State: AOJu0YwUrso7Hd+GwEf0jJtmYbKgGHfEe1CqKy0+LffRVgmT1ixPBSOH
	G8NVN3jDSdYOC1lQ/mulud+zCz1HDPJsRMuObQadGALsjWAhSjGTTyMHNCBR
X-Google-Smtp-Source: AGHT+IFyM6lQ6KJveAe2z7Gmk1noQ5MtfV7G4Jbdhvw+58F7bAORE8gBeAcc0iGQTOJZL7cxlB+KlQ==
X-Received: by 2002:a17:902:654c:b0:1e8:8aa2:2ded with SMTP id d12-20020a170902654c00b001e88aa22dedmr12744422pln.13.1713762629956;
        Sun, 21 Apr 2024 22:10:29 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id p9-20020a170902bd0900b001e4565a2596sm7144866pls.92.2024.04.21.22.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 22:10:28 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+e84662c5f30b8c401437@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jffs2?] [nilfs?] KASAN: slab-use-after-free Read in jffs2_garbage_collect_pass
Date: Mon, 22 Apr 2024 14:10:24 +0900
Message-Id: <20240422051024.137484-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <00000000000032adb00615568aee@google.com>
References: <00000000000032adb00615568aee@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test slab-use-after-free Read in jffs2_garbage_collect_pass

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

