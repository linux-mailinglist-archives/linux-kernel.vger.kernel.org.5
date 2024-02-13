Return-Path: <linux-kernel+bounces-64476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C7A853EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0079B28601F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A8062177;
	Tue, 13 Feb 2024 22:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NxPVyx+O"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B310626A1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864201; cv=none; b=Tr53bobqcg2XxPJrsVAKjkdyU9uw/v9s6wQULMKcD61eFArZsdnPXmOxmrhcNaPD+IddInWodD7E8dlZOCRe7FJeUivHZ0lBas5Vw2yhyWarJiFLl0kdNP1Pbc8NjFGryccQE7pWJxyb9OCRoTZYPjr/zSiZzkUnq56XCeINBjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864201; c=relaxed/simple;
	bh=J0YREw/SPxXRlg+9852zs8Ylph5MBgvao6PSfGqmaBE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qTABwSyw8Z0pOfyauttITrBIdra4IBbeMIWhRMYMGsITK+dNUOKaJan3NMtvTVZr6g9z1mfIz1GICu4JWDqvEX6Byedj9rQnKuyCMJydb14Ejleo/iTwqzdEqSlZw+kJfEa2C+dn+YoOQ2dRjUtT99VhO20N/A5EJa9blkCwKn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NxPVyx+O; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ee22efe5eeso85306307b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707864199; x=1708468999; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lHJiifufVzDkMZAoUjH+SKnrhFUND46ohEe45AXq8HI=;
        b=NxPVyx+O2Rp79vG9eQ/W0Snw7omgc0Ncloe9qXCVxGdU5lFKXifSUcAALuzt3VdT5w
         +3FNPLL8AEkc0MmVjDy6OyY1rcPBK89I0cqOHt/gvYK0VeB+kvZdvpR5XXcslgB79elT
         DSmP+i3aIe4QAwSlkVtlZ1VAeRdUP9zvNDYr7TlvFXqwC6X7oFlCLHJKbHO9fdE4jW4i
         FBq6cnNxC8Lr8K/oC5Hjqjj19IKOOqq8orSHhNbp9meJyOZ9sXuSXuOm8uVH3IMrRGnU
         hZZ61GCNcAemXYcyd5rDs0d1cHNEpHcR8B8NOTDmhsZe/oJj4I7Hz8EFyCkG5zSUwDSi
         7NUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707864199; x=1708468999;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lHJiifufVzDkMZAoUjH+SKnrhFUND46ohEe45AXq8HI=;
        b=KsLo3mdnMJHVv1HW3WX4TvBSBhHxSPaX6KK1UjBGiY91EzCay909F8ob5bPXpReK9L
         PYYbUrU43CKN4qX5ux62fa805syy9ocCt4VtB9/pP7nBofOikVycoYR0dC2Xins7Vj7K
         lwr9p0oF8QKkAsNd54J34o82SaHo6wul4hUVXqC9ibn3mclCHDal1LUlN/vyVa3iheqe
         EIFkx7LbeRLVzeZnBbi4RmbDSeFLTLPFzcFor1clSzKbdJ5krC402UiMfUogBWK4VBlt
         d7R23yw6Z3CEFvoDQKkGS66J9SqU1x1WWhDOt6DIKxMIY8DkhCJVlFekTsh1KZ8tGVtC
         gF9g==
X-Forwarded-Encrypted: i=1; AJvYcCWYP8zHd48dqWXq02UwCmFpP3sA77hTIcYfk83guwStW4JQbCsSetWUXRmU8nird8j0+Q9Q0ymNkaEE2DJZmVOiEIMlLzHTvbaYjloD
X-Gm-Message-State: AOJu0Yz2K1cGr7laH7IZyp46grcnlquslWT9Ulocmtcq1Y6GP7o60xaN
	D6NuzzzKPT36dJUFgAzuBaxtmRt/AcMoqwNZp3Jp6GF2HVkDj0Tm6IzA1Yng4vkrmbTqqrpEsXK
	5CvNy3ffrB5o1PlVXSg==
X-Google-Smtp-Source: AGHT+IGy7Og0OsIVjKDJo37wYxV4WnvwVhbxROaRt5+vFuGWYAQMwlYj2CtildNGUmlCAlu1PHbcWHRYYQGE1wjI
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a05:6902:1243:b0:dbe:30cd:8fcb with
 SMTP id t3-20020a056902124300b00dbe30cd8fcbmr17019ybu.0.1707864199209; Tue,
 13 Feb 2024 14:43:19 -0800 (PST)
Date: Tue, 13 Feb 2024 22:43:07 +0000
In-Reply-To: <2d4d939d-4b49-44d7-8405-e075de844884@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2d4d939d-4b49-44d7-8405-e075de844884@sifive.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213224308.2598732-1-ericchancf@google.com>
Subject: Re: [PATCH v4 3/4] riscv/barrier: Consolidate fence definitions
From: Eric Chan <ericchancf@google.com>
To: samuel.holland@sifive.com
Cc: aou@eecs.berkeley.edu, ericchancf@google.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com
Content-Type: text/plain; charset="UTF-8"

Hi Samuel,

  Thanks for pointing out the negligence, I think we should keep the optimization.
  I've updated patch v5 at [0].
  Thank for the reviewing and suggestions.

[0] [https://lore.kernel.org/lkml/20240213223810.2595804-1-ericchancf@google.com/]

Sincerely,
  Eric Chan

