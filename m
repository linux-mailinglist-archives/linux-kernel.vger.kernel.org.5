Return-Path: <linux-kernel+bounces-88511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC5186E2B0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09E71C22C48
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9DD6EB56;
	Fri,  1 Mar 2024 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhFGHt9H"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8D7386;
	Fri,  1 Mar 2024 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300810; cv=none; b=ZuiwyETtswiAMTBF9ZjSw88vw3HWsgPpwqlXM+Aes84j1VfQd9zg6peyBOs9BKPgdl+ZovzZAQ14GEKAg5O9i+dJYUPwWFwF8et3oOgsX1ltimMqdXGtQpJSj7HsmM0tDP5O/U+JjY6hf/eji53T54m2twWWTECMPorMXtMkGPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300810; c=relaxed/simple;
	bh=54FFq9yRx8MYuVhw3vkGHx7fdD7CrqETGUwW/4CAovY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c6pWN7tPI3KEJCq9vPA+OnhgQEoCpDv9ypDa3CuasheJ7+AutxB/JLlellpFzo0qE08IjZMjfc/R9V3w/NEW5PJ0/8QW12b/9/J8yo4u82Wy/yKeWTHQbFHc1snHQbzS84kC1i1uG/InEjhxBTaRf1WrWZMDmsT5t0IMoH7QtVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhFGHt9H; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-565a2c4cc1aso3222896a12.2;
        Fri, 01 Mar 2024 05:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709300807; x=1709905607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yaHYFmAj2a1qF5bLRyGFMlUXUbLIC303Xpdp1+Wxpss=;
        b=bhFGHt9H8ZsS3+ux3BG/7jENxIM2xxY4ladt0DZXCOM/wtKbLCcpc7zj4JtwpNVeKE
         nmPMBjnt86SneFfk+J/MupQ89nlTu+Kt9Hdc5toNj4BYIl7h6VcShTamE6rFE2pmIe28
         T41Pf6YSY+b5JNCh0SplgVWgUhTc2WR13eb7yzh50sW9oQFrHXIC9umFeJqZU7tfNi9N
         eB2OoqsUYJZMgQMpMpXy3Y7VUrYU5JRKMG1xO3ZGIeKvb1ZuJfhFwXoN85WEkUZK/ri8
         /goYvyPGJ2mmN6yJDtRRqAp/SGTG6c3l/iNFGwKunlf7vlcQm572MVk2ZhR8dDYSlHz7
         N/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709300807; x=1709905607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yaHYFmAj2a1qF5bLRyGFMlUXUbLIC303Xpdp1+Wxpss=;
        b=AC2oFtSmE/6RCx/arw329gG1vsPdVwN4RfoPoC0TRIRzu8bzurPSXma6zX077Ienaw
         6TUlVOjTiOE/uv9pkn5rgimcn9tJfwfdDQnW/MMrFtPRBVpd5aEhmXzlvwrk4ZOd7iWC
         zCyzjmNH/IDpkF/g3IJm+4HAWjhQTIIBuxg5O7tUwC4d650Ba4upiSvNmHAPNX9sqZU1
         x71xb/AMDATNXqXBXUvBdHxeFq6gTMYpMdJOdqQ0jOa4JsxTvtZ7V/kpSKdmbW0WJ+1F
         jUS6ftc80wN6YfWlBC/cpNh8vh2xhUzXqRJgP2sT08Ft0oqxTmCBZ1ExaLQIrY9ihO0S
         EN7A==
X-Forwarded-Encrypted: i=1; AJvYcCWC3QFN8ZJg4/8FbXNb1Q4OUvwZh22OrEszDwJ7jYLfzCbCWycNs2AuOgDYIV0bl/F7L5oFYz68H5d8G544B/Q2HZh3q8P+KShDq+tY5cFMPPAJmcp8W5FLgropQj78aPw0oObj+yxB/FUtQyCtHv83L6MjvnHkyxKZgoW/k5pHoC/h
X-Gm-Message-State: AOJu0YwgLoBmnHY45oWefaG352lXppK7QEI42F+aXi/tJA55XA1R55sr
	pUmTfU2vwChgqd6THmwb+erfdnYKvSvPtyF9ianT/N8AB9V+znMqFHarc2FqmVc=
X-Google-Smtp-Source: AGHT+IG2ZWNiDZ/UapF2emTgF/bCbiuQ7tutc4XzcrVhKozADdzWclYYDUbgLtjEov25z51CeWOB5g==
X-Received: by 2002:a50:cbc9:0:b0:565:1780:9399 with SMTP id l9-20020a50cbc9000000b0056517809399mr1267962edi.25.1709300806508;
        Fri, 01 Mar 2024 05:46:46 -0800 (PST)
Received: from lola.. ([2a02:810d:7e40:14b0:d371:e319:5dd0:9b35])
        by smtp.gmail.com with ESMTPSA id fj10-20020a0564022b8a00b00563f8233ba8sm1584107edb.7.2024.03.01.05.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 05:46:46 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 0/3] Towards a re-organized submitting patches
Date: Fri,  1 Mar 2024 14:46:34 +0100
Message-ID: <20240301134637.27880-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear Jonathan,

I wanted to clean up the development-process documentation. There is
however no easy way to break the ice here:

The elephant in the room is that there is some unclear relation between
5.Posting.rst, 6.Followthrough.rst and submitting-patches.rst.
(Yes, I know each document has its own history...; but let us put the
history aside for now.)

Submitting-patches.rst contains information largely put together from
different initial starting points and is partly outdated due to common
workflows with git format-patch and git send-email.

Often when new additions are made, they are somehow added to both
documents with slightly different wording.

Also, looking at the word count (with wc -l) on next-20240227:

  2917 5.Posting.rst
  2136 6.Followthrough.rst
  5878 submitting-patches.rst

So, from the numbers, you would expect that submitting-patches.rst is a
detailing of Posting and Followthrough.
However, it is really difficult to see how submitting-patches.rst would
be a refinement of Posting and Followthrough or if and where it is not.
First, at the moment, the different initial starting points and different
ordering somehow makes it difficult to judge.

Also, the factor of 20% more words really does not indicate much more
content in submitting-patches compared to Posting and Followthrough.

For a simple experiment, I moved the larger parts on the tags
(signed-off-by, co-developed-by, acked-by, reported-by, etc.) into a
separate document and then ran the numbers on submitting-patches again:

  4329 submitting-patches.rst

Nowt, the size of submitting-patches is actually below Posting and
Followthrough.

So, the difficult task to reach a coherent process description is to see
some relation between these documents and then go through the editorial
changes. I have come up with this kind of vision:

Phase 1: Clean up submitting patches

  Topics/Statements that can be easily cleaned up first do not get in
  the way (at least mentally) when trying to understand the next steps.
  
  E.g., as an experiment I moved the details on tags into a separate
  document.
  
Phase 2: Make submitting-patches have one clear temporal flow.

  The top-level structure should basically be along the temporal order of
  things: Prepare a patch, Post a patch, Respond to review, Send reworked
  patches, Be patient before resending

  "No MIME, no links, no compression, no attachments. Just plain text"
  needs to be reworked into "Send your patch".
  
  The content from the canonical patch format needs to evaluated on
  relevance with a git workflow and the important pieces need to be
  included into the temporal flow.

  In other words, it is worth describing "the canonical patch format" much
  more from what the submitter may add where and in which format rather
  than explaining the purpose of some things that git format-patch does by
  default and usually nobody would play around with.

  Probably, prepare a patch will need to be broken down a bit in some
  smaller steps. The "Send reworked patch" section is new and needs to
  include content distributed throughout submitting-patches.
  
Phase 3: Merge the pieces of content from Posting and Followthrough into
submitting patches if it adds something to that document.

  When both documents roughly cover the topics of similar depth, we look
  fine-grained into how to construct the one document that has the best
  from both documents.
  
Phase 4: Remove Posting and Followthrough and simply replace it in the
process description with submitting patches.
  
  In some way, when both documents cover the topic in similar depth either
  document could be deleted.
  However, the name "submitting patches" is probably already stuck too much
  with the community; I have seen many presentations referring to
  submitting patches, but I have not seen anyone referring to '5.Posting'
  in any presentation.

  Also, the number of references---excluding translations---to Posting and
  Followthrough, submitting_patches.rst is 3, 1 and 41, respectively.
  In fact, the two references in handling-regressions mention Posting just
  as further reference next to submitting patches, clearly just indicating
  this kind of duplication. So, submitting-patches is much more stuck with
  the community at the current state and once the content from Posting is
  added to submitting-patches, Posting will not be missed.

  Further, this requires to rewrite the process description intro
  and the intro of submitting patches a bit, such that if readers:

  - just jump into submitting-patches from the top page,
  - or are going through the development-process from cover to cover
    (coming from its section 4 and moving on to section 7)

  they see a roughly consistent flow of thought and suitable introduction.
  But I think this should be feasible.

Let us see how long it takes me to work through this and convince the
reviewers and future readers that we are moving a good direction.

So, here are some first changes to Phase 1 and Phase 2.

Current state:

I spend roughly two days of work---besides the usual distractions---on
this topic, digging into the documents and trying to make a plan.

Obviously, the final goal is not reached with this series, but I would
like to get first feedback and hope that we can get the first patches
generally accepted (but not necessarily included into the repository yet
if only truly accepted when seeing the full picture of changes) to
continue the rework with some backing confidence that this is not all in
vain.

Please let me know if this is going in the right direction and if some
patches would already be accepted to be included upfront to lower the
risks and conflicts when continuing the editorial work.

Well, long text... some short simple patches for now.


Best regards,

Lukas


Lukas Bulwahn (3):
  docs: submitting-patches: divert focus from PATCH in the subject line
  docs: submitting-patches: move split_changes before describe_change
  docs: submitting-patches: move backtraces to patch description

 Documentation/process/submitting-patches.rst | 119 +++++++++----------
 1 file changed, 58 insertions(+), 61 deletions(-)

-- 
2.43.2


