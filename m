Return-Path: <linux-kernel+bounces-35532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6828392AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3FCA28598F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194C75FEEA;
	Tue, 23 Jan 2024 15:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGa+2LKs"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495085FDB2;
	Tue, 23 Jan 2024 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023678; cv=none; b=DaYbhiD49Bj6scgPtWF/12hUCnjpo/WizFOhMtztJ1sUyn6PpcwAO0s0h4nmTnIAO4oSbRLF/jese8tYv9YBosTh5ExNoOtcuYegQl5tPkGoJXzu6pT/0+zfx8CmCEfdmnEvr38UdCy3yxo9VhOXfNZjrmt+9LwHP7NxagK9D9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023678; c=relaxed/simple;
	bh=bRtZ8cJ+QwR8M/kuDnh4BR7oHFzlsBbPU1aBIHQNz9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLn/++HvjY4Jm9r3qqiL8AKqCC6DWKIfpRiCYhdcHcavIz0505HpnJVB+pjl1qM1NqD8UMZsCLGj1wLvxBHJwfJsLSVtyveeUbzushUuC3rdHOIIZRl7gTRqhZ1uX/nOwHsH5Xefh10whjRR1dVIKNKiYpU9QYGv1n3Lm4mVorM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGa+2LKs; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a28ab7ae504so366598766b.3;
        Tue, 23 Jan 2024 07:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706023674; x=1706628474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B6ZMq5ex0QtA0MuvtePXEQg0PgGhw3bC2ICB5YA19E0=;
        b=TGa+2LKsYuq+RBZNJisbNfJHVcc9QMezb1fXswpl6IEdRVMr1NGIlDvl1EpQczjAzz
         NuutjayLMPA0KgItwBAPJmbceoNfjTQcidWgO5BxM2lkDkFVUarcxIh8HwOa5htBy6/V
         BhSXpvs2y96DE5+DGVTlenU3cz04PumW//TRiSorVmCZEmq1AN8u6wCawD6UhmQoDGUl
         CfyiKUP9UsYTj4CG0U9/O3t3s3j6KsmgYMCOg0+aByds85VmlLEUuAFJvucGQfLStmC0
         86H56d1Lh/BwkrCJbdTnv/SC7fyI3v6ji1O66m3FvXSH5YPL7T59cTnjoco+gQ0baRHH
         dkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706023674; x=1706628474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6ZMq5ex0QtA0MuvtePXEQg0PgGhw3bC2ICB5YA19E0=;
        b=lifTrpVsjFMu3EgajTFYvE/e+2g+qbEMnM8ECzC/fkAUCsODU6zKrsdH46b6UGNcmC
         prNOrvexx8eVdunbDq0Lm7ie4fzES1HiVgEbtSrUH0M2VaQ0hbXMhoFroFiIADQcZ5Mt
         nFhhP4C0A6dBtNf6M00zaDepTFq2s2v0eLwJhTe61YiEKPtWmMZeOrZHPbr7C6Zjm20a
         JEQvHqiaLzqBeVu5j3FhukVUrN1UNC1NypCPTar2wp4MRvDo3ZEINOkA9ml/qUQrmO3D
         dfgDmvy+kvo1CiIiuyZ5tac8upHQVnVaIjPRyf2vApm5ZIkKtWmGgK8UEkaabBstOjui
         UYKg==
X-Gm-Message-State: AOJu0YzP5YAaG8JFYl8WMb527ZT/5jiNt/xTA9eryuofBoCE0u1+Kd6l
	xI1e3nUkHRb6P81EXc/pu5fHTZkg+4SUOXuRhUorFB8SjzJTtVbS
X-Google-Smtp-Source: AGHT+IHPwOiv77lLmsj5UFp9tbvAB2S2zDhu3oL8S3pR9rp1DjZ6o3L4TZFSBvdfGY2Evf4b6R6MZQ==
X-Received: by 2002:a17:906:6a1c:b0:a27:a258:f340 with SMTP id qw28-20020a1709066a1c00b00a27a258f340mr32465ejc.65.1706023673959;
        Tue, 23 Jan 2024 07:27:53 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709066dd900b00a26af4d96c6sm14572870ejt.4.2024.01.23.07.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:27:53 -0800 (PST)
Date: Tue, 23 Jan 2024 17:27:51 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tim Menninger <tmenninger@purestorage.com>
Cc: Andrew Lunn <andrew@lunn.ch>, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: mv88e6xxx: Make *_c45 callbacks agree with
 phy_*_c45 callbacks
Message-ID: <20240123152751.gejixrmyet7bsc3j@skbuf>
References: <20240116193542.711482-1-tmenninger@purestorage.com>
 <04d22048-737a-4281-a43f-b125ebe0c896@lunn.ch>
 <CAO-L_44YVi0HDk4gC9QijMZrYNGoKtfH7qsXOwtDwM4VrFRDHw@mail.gmail.com>
 <da87ce82-7337-4be4-a2af-bd2136626c56@lunn.ch>
 <CAO-L_46kqBrDdYP7p3He0cBF1OP7TJKnhYK1NR_gMZf2n_928A@mail.gmail.com>
 <20240122123349.cxx2i2kzrhuqnasp@skbuf>
 <1aab2398-2fe9-40b6-aa5b-34dde946668a@lunn.ch>
 <20240122151251.sl6fzxmfi2f6tokf@skbuf>
 <CAO-L_45_nZ24pvycdahEy0OP2tZjxCw40_o6HE-_C4jmsX3b8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-L_45_nZ24pvycdahEy0OP2tZjxCw40_o6HE-_C4jmsX3b8g@mail.gmail.com>

On Mon, Jan 22, 2024 at 07:46:06AM -0800, Tim Menninger wrote:
> Andrew, would you feel differently if I added to the patch the same
> logic for C22 ops? Perhaps that symmetry should have existed
> in the initial patch, e.g.
> 
>     bus->read = chip->info->ops->phy_read
>         ? mv88e6xxx_mdio_read : NULL;
>     bus->write = chip->info->ops->phy_write
>         ? mv88e6xxx_mdio_write : NULL;
>     bus->read_c45 = chip->info->ops->phy_read_c45
>         ? mv88e6xxx_mdio_read_c45 : NULL;
>     bus->write_c45 = chip->info->ops->phy_write_c45
>         ? mv88e6xxx_mdio_write_c45 : NULL;

Here it's me who would disagree, for the simple fact that it's not
needed, and we shouldn't complicate the code with things that are not
needed (and also, bug fixes should not make more logical changes than
strictly necessary). All mv88e6xxx_ops structure provide the C22
phy_read() and phy_write(). As listed below, in order:

static const struct mv88e6xxx_ops mv88e6085_ops = {
	.phy_read = mv88e6185_phy_ppu_read,
	.phy_write = mv88e6185_phy_ppu_write,
};

static const struct mv88e6xxx_ops mv88e6095_ops = {
	.phy_read = mv88e6185_phy_ppu_read,
	.phy_write = mv88e6185_phy_ppu_write,
};

static const struct mv88e6xxx_ops mv88e6097_ops = {
	.phy_read = mv88e6xxx_g2_smi_phy_read_c22,
	.phy_write = mv88e6xxx_g2_smi_phy_write_c22,
	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
};

static const struct mv88e6xxx_ops mv88e6123_ops = {
	.phy_read = mv88e6xxx_g2_smi_phy_read_c22,
	.phy_write = mv88e6xxx_g2_smi_phy_write_c22,
	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
};

static const struct mv88e6xxx_ops mv88e6131_ops = {
	.phy_read = mv88e6185_phy_ppu_read,
	.phy_write = mv88e6185_phy_ppu_write,
};

static const struct mv88e6xxx_ops mv88e6141_ops = {
	.phy_read = mv88e6xxx_g2_smi_phy_read_c22,
	.phy_write = mv88e6xxx_g2_smi_phy_write_c22,
	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
};

static const struct mv88e6xxx_ops mv88e6161_ops = {
	.phy_read = mv88e6xxx_g2_smi_phy_read_c22,
	.phy_write = mv88e6xxx_g2_smi_phy_write_c22,
	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
};

static const struct mv88e6xxx_ops mv88e6165_ops = {
	.phy_read = mv88e6165_phy_read,
	.phy_write = mv88e6165_phy_write,
};

static const struct mv88e6xxx_ops mv88e6171_ops = {
	.phy_read = mv88e6xxx_g2_smi_phy_read_c22,
	.phy_write = mv88e6xxx_g2_smi_phy_write_c22,
	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
};

static const struct mv88e6xxx_ops mv88e6172_ops = {
	.phy_read = mv88e6xxx_g2_smi_phy_read_c22,
	.phy_write = mv88e6xxx_g2_smi_phy_write_c22,
	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
};

static const struct mv88e6xxx_ops mv88e6175_ops = {
	.phy_read = mv88e6xxx_g2_smi_phy_read_c22,
	.phy_write = mv88e6xxx_g2_smi_phy_write_c22,
	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
};

static const struct mv88e6xxx_ops mv88e6176_ops = {
	.phy_read = mv88e6xxx_g2_smi_phy_read_c22,
	.phy_write = mv88e6xxx_g2_smi_phy_write_c22,
	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
};

static const struct mv88e6xxx_ops mv88e6185_ops = {
	.phy_read = mv88e6185_phy_ppu_read,
	.phy_write = mv88e6185_phy_ppu_write,
};

static const struct mv88e6xxx_ops mv88e6190_ops = {
	.phy_read = mv88e6xxx_g2_smi_phy_read_c22,
	.phy_write = mv88e6xxx_g2_smi_phy_write_c22,
	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
};

static const struct mv88e6xxx_ops mv88e6190x_ops = {
	.phy_read = mv88e6xxx_g2_smi_phy_read_c22,
	.phy_write = mv88e6xxx_g2_smi_phy_write_c22,
	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
};

static const struct mv88e6xxx_ops mv88e6191_ops = {
	.phy_read = mv88e6xxx_g2_smi_phy_read_c22,
	.phy_write = mv88e6xxx_g2_smi_phy_write_c22,
	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
};

static const struct mv88e6xxx_ops mv88e6240_ops = {
	.phy_read = mv88e6xxx_g2_smi_phy_read_c22,
	.phy_write = mv88e6xxx_g2_smi_phy_write_c22,
	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
};

static const struct mv88e6xxx_ops mv88e6250_ops = {
	.phy_read = mv88e6xxx_g2_smi_phy_read_c22,
	.phy_write = mv88e6xxx_g2_smi_phy_write_c22,
	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
};

static const struct mv88e6xxx_ops mv88e6290_ops = {
	.phy_read = mv88e6xxx_g2_smi_phy_read_c22,
	.phy_write = mv88e6xxx_g2_smi_phy_write_c22,
	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
};

static const struct mv88e6xxx_ops mv88e6320_ops = {
	.phy_read = mv88e6xxx_g2_smi_phy_read_c22,
	.phy_write = mv88e6xxx_g2_smi_phy_write_c22,
	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
};

static const struct mv88e6xxx_ops mv88e6321_ops = {
	.phy_read = mv88e6xxx_g2_smi_phy_read_c22,
	.phy_write = mv88e6xxx_g2_smi_phy_write_c22,
	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
};

static const struct mv88e6xxx_ops mv88e6341_ops = {
	.phy_read = mv88e6xxx_g2_smi_phy_read_c22,
	.phy_write = mv88e6xxx_g2_smi_phy_write_c22,
	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
};

static const struct mv88e6xxx_ops mv88e6350_ops = {
	.phy_read = mv88e6xxx_g2_smi_phy_read_c22,
	.phy_write = mv88e6xxx_g2_smi_phy_write_c22,
	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
};

static const struct mv88e6xxx_ops mv88e6351_ops = {
	.phy_read = mv88e6xxx_g2_smi_phy_read_c22,
	.phy_write = mv88e6xxx_g2_smi_phy_write_c22,
	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
};

static const struct mv88e6xxx_ops mv88e6352_ops = {
	.phy_read = mv88e6xxx_g2_smi_phy_read_c22,
	.phy_write = mv88e6xxx_g2_smi_phy_write_c22,
	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
};

static const struct mv88e6xxx_ops mv88e6390_ops = {
	.phy_read = mv88e6xxx_g2_smi_phy_read_c22,
	.phy_write = mv88e6xxx_g2_smi_phy_write_c22,
	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
};

static const struct mv88e6xxx_ops mv88e6390x_ops = {
	.phy_read = mv88e6xxx_g2_smi_phy_read_c22,
	.phy_write = mv88e6xxx_g2_smi_phy_write_c22,
	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
};

static const struct mv88e6xxx_ops mv88e6393x_ops = {
	.phy_read = mv88e6xxx_g2_smi_phy_read_c22,
	.phy_write = mv88e6xxx_g2_smi_phy_write_c22,
	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
};

> Vladimir, as far as style I have no objections moving to straightlined
> if's. I most prefer to follow the convention the rest of the code follows
> and can change my patch accordingly.

Yes, so my objections have to do with code style and with the structure
of the commit message.

It should have been a more linear description of: user impact of the
problem -> identify the cause -> why the existing mechanism to prevent
the issue does not work -> what can be done to resolve the problem ->
see if this is consistent with what is done elsewhere -> why the
proposed change does not break other things -> optionally consider
alternative solutions and explain why this one is better.

Basically be as preemptive as possible w.r.t. questions that might be
crossing readers' minds as they read the commit. You should view any
clarification question you receive during review as a potential
improvement you could make to the commit message or comments.

Also, the commit title should focus on what is being fixed from a user
impact perspective. And the Fixes: tag should normally be a single one,
which coincides with what 'git blame' finds (corollary: bugs which have
no user visible impact are not treated like bugs, and are fixed as part
of the "net-next" tree).

Also, there should be no blank lines between the Fixes: and Signed-off-by:
tags. And the next patch revision should be generated with git
format-patch --subject-prefix "PATCH net v2" to clarify it is targeted
to the https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
tree for fixes. See the warning here (Target tree name not specified in
the subject).
https://patchwork.kernel.org/project/netdevbpf/patch/20240116193542.711482-1-tmenninger@purestorage.com/

The space beneath the "---" line in the formatted patch is not processed
by git when applying the patch. You can use it for extra info such as
change log compared to v1, and a link to v1 on lore.kernel.org.

