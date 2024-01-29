Return-Path: <linux-kernel+bounces-43373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5781E8412D9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC141F26273
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D032E85E;
	Mon, 29 Jan 2024 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhS38+Lj"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475104CB5B;
	Mon, 29 Jan 2024 18:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554556; cv=none; b=n7vbpKbjfQFs+IkUYfwUH8V7oqfUbg5bwVgqZNPSFa1FREEWBw3n1avqtSpHPOnlnSCvML60okkXXgHSClEV9FJgeB8JWEH0Z7vjbCT3eZLKuaBKJ+7ze029EnSbCFoAJxiAVTLfCcPNOtJZmSxHkz2nK2PuMc46Qjx/BaAxKsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554556; c=relaxed/simple;
	bh=PxWRYyJaWkpU4HOj0Lf/k+4unKP8OrbIuP66pT3Nj+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=avmjCkVO4bPydL1Os/pCnovW2bdK2Bkk5HzFmJrS3PGpMm/MHkEUOXp72j5xEP6LorW4WrK92Us6+fEC41Nw/dd6KEstgYEZB0cUukx+V6kuOmTavcbN/HBBde2BQGGskiU1axl9XQBQ2jyfnXaRiO4zye867YE2RUY8MRJJG6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhS38+Lj; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2906855ac5fso1313888a91.3;
        Mon, 29 Jan 2024 10:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706554553; x=1707159353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aKDmV2iIo+f+rtsf60grM4KXtbddvMAF0R3jEiOj6FE=;
        b=XhS38+Lj7A0nnsLMC0DM3ni2aJEypHkRWKf/1FJfYVceTyYHQCzpS4zv93SNd1rGCn
         QkgSQ0ddlsoK/VU6rJIY4EsXC0oAH1bsZu2hVJmSf1mimHpLanfeOttOrSxlRIZTf1Cw
         n1SGgn+OJaGgTGhPyLMPJ4q5LajlbIcm7vPAazRr1mEcp5kRSHlF3oBCBxejYgLiAyvT
         e800VSM1GkISWH+1+Q8M1LXpz9n90h2jFgjVgm+WmorI1XliFbGQTqIwJyI/AqcjNUcf
         3SWVLY0OEdevtq3H2te/yqCQtM8pKR1gHLtxbCxsKVSZkw6C7Bt4HcY5VEKvIbqM+0Mv
         fWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706554553; x=1707159353;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKDmV2iIo+f+rtsf60grM4KXtbddvMAF0R3jEiOj6FE=;
        b=EGRD3aT2oQnZNOgozywgmgnbH0cwsFMJKl2AXN2++MoK1DNWw1QNezo4Jv+uc+Abw6
         VZ54L1EEuudSWGCtPr8XcxhuMIAhP9e0wZ2IsefErW5oBAC5auD0SVSdV6KK7t5EP2RX
         AAoumCudBvbnPQPy9WFGwBSb7jURewGTOaPpfC7AsiN+OjNEbyl7rwyyTAz+FGiGHkA2
         x8wzfOu+c3qSLdlztCHp/KVg4IYCQ0musjunfJOX2GERlp3z+64TSpQnW56KY6BJk3+p
         3NTn0dlXC4k82igMyTLfzLKeeJcqz5dJtlpKCgf6CsHxXNquPY8lMY+QrRAmBSYEEEEj
         1bnw==
X-Gm-Message-State: AOJu0YxtxATSEBMrI6/CjkCYl0JezwbnVIQQnNDCDb3OfBkE5jmmXc81
	HxWSarW+iyuukhLK7ugtQJOHHBj07WbbVuSN0EezSdWJhq8k2XkRLQfXjyWq
X-Google-Smtp-Source: AGHT+IGtLNowEeUqRIbKjwZ7TeMlzr3W8tqsN42sdMpqHRo6UKOrfxHN6lnh+MkXDRPp9vzPXL8+7w==
X-Received: by 2002:a17:90a:bf18:b0:293:e9f0:df7f with SMTP id c24-20020a17090abf1800b00293e9f0df7fmr2629829pjs.11.1706554553336;
        Mon, 29 Jan 2024 10:55:53 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id f21-20020a17090ac29500b0028d134a9223sm5406254pjt.8.2024.01.29.10.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 10:55:52 -0800 (PST)
Message-ID: <dda587dc-0d97-4954-891a-9b8eacbc22eb@gmail.com>
Date: Mon, 29 Jan 2024 10:55:51 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: mv88e6xxx: Make *_c45 callbacks agree with
 phy_*_c45 callbacks
Content-Language: en-US
To: Tim Menninger <tmenninger@purestorage.com>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240116193542.711482-1-tmenninger@purestorage.com>
 <04d22048-737a-4281-a43f-b125ebe0c896@lunn.ch>
 <CAO-L_44YVi0HDk4gC9QijMZrYNGoKtfH7qsXOwtDwM4VrFRDHw@mail.gmail.com>
 <da87ce82-7337-4be4-a2af-bd2136626c56@lunn.ch>
 <CAO-L_46kqBrDdYP7p3He0cBF1OP7TJKnhYK1NR_gMZf2n_928A@mail.gmail.com>
 <20240122123349.cxx2i2kzrhuqnasp@skbuf>
 <1aab2398-2fe9-40b6-aa5b-34dde946668a@lunn.ch>
 <20240122151251.sl6fzxmfi2f6tokf@skbuf>
 <CAO-L_45_nZ24pvycdahEy0OP2tZjxCw40_o6HE-_C4jmsX3b8g@mail.gmail.com>
 <20240123152751.gejixrmyet7bsc3j@skbuf>
 <CAO-L_47uktW8onKHG7fQk1gka2zFWHZb4D6ZBgcKULr8QVfvaQ@mail.gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAO-L_47uktW8onKHG7fQk1gka2zFWHZb4D6ZBgcKULr8QVfvaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/29/24 10:53, Tim Menninger wrote:
> On Tue, Jan 23, 2024 at 7:27 AM Vladimir Oltean <olteanv@gmail.com> wrote:
>>
>> On Mon, Jan 22, 2024 at 07:46:06AM -0800, Tim Menninger wrote:
>>> Andrew, would you feel differently if I added to the patch the same
>>> logic for C22 ops? Perhaps that symmetry should have existed
>>> in the initial patch, e.g.
>>>
>>>      bus->read = chip->info->ops->phy_read
>>>          ? mv88e6xxx_mdio_read : NULL;
>>>      bus->write = chip->info->ops->phy_write
>>>          ? mv88e6xxx_mdio_write : NULL;
>>>      bus->read_c45 = chip->info->ops->phy_read_c45
>>>          ? mv88e6xxx_mdio_read_c45 : NULL;
>>>      bus->write_c45 = chip->info->ops->phy_write_c45
>>>          ? mv88e6xxx_mdio_write_c45 : NULL;
>>
>> Here it's me who would disagree, for the simple fact that it's not
>> needed, and we shouldn't complicate the code with things that are not
>> needed (and also, bug fixes should not make more logical changes than
>> strictly necessary). All mv88e6xxx_ops structure provide the C22
>> phy_read() and phy_write(). As listed below, in order:
>>
>> static const struct mv88e6xxx_ops mv88e6085_ops = {
>>          .phy_read = mv88e6185_phy_ppu_read,
>>          .phy_write = mv88e6185_phy_ppu_write,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6095_ops = {
>>          .phy_read = mv88e6185_phy_ppu_read,
>>          .phy_write = mv88e6185_phy_ppu_write,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6097_ops = {
>>          .phy_read = mv88e6xxx_g2_smi_phy_read_c22,
>>          .phy_write = mv88e6xxx_g2_smi_phy_write_c22,
>>          .phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
>>          .phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6123_ops = {
>>          .phy_read = mv88e6xxx_g2_smi_phy_read_c22,
>>          .phy_write = mv88e6xxx_g2_smi_phy_write_c22,
>>          .phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
>>          .phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6131_ops = {
>>          .phy_read = mv88e6185_phy_ppu_read,
>>          .phy_write = mv88e6185_phy_ppu_write,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6141_ops = {
>>          .phy_read = mv88e6xxx_g2_smi_phy_read_c22,
>>          .phy_write = mv88e6xxx_g2_smi_phy_write_c22,
>>          .phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
>>          .phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6161_ops = {
>>          .phy_read = mv88e6xxx_g2_smi_phy_read_c22,
>>          .phy_write = mv88e6xxx_g2_smi_phy_write_c22,
>>          .phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
>>          .phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6165_ops = {
>>          .phy_read = mv88e6165_phy_read,
>>          .phy_write = mv88e6165_phy_write,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6171_ops = {
>>          .phy_read = mv88e6xxx_g2_smi_phy_read_c22,
>>          .phy_write = mv88e6xxx_g2_smi_phy_write_c22,
>>          .phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
>>          .phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6172_ops = {
>>          .phy_read = mv88e6xxx_g2_smi_phy_read_c22,
>>          .phy_write = mv88e6xxx_g2_smi_phy_write_c22,
>>          .phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
>>          .phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6175_ops = {
>>          .phy_read = mv88e6xxx_g2_smi_phy_read_c22,
>>          .phy_write = mv88e6xxx_g2_smi_phy_write_c22,
>>          .phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
>>          .phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6176_ops = {
>>          .phy_read = mv88e6xxx_g2_smi_phy_read_c22,
>>          .phy_write = mv88e6xxx_g2_smi_phy_write_c22,
>>          .phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
>>          .phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6185_ops = {
>>          .phy_read = mv88e6185_phy_ppu_read,
>>          .phy_write = mv88e6185_phy_ppu_write,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6190_ops = {
>>          .phy_read = mv88e6xxx_g2_smi_phy_read_c22,
>>          .phy_write = mv88e6xxx_g2_smi_phy_write_c22,
>>          .phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
>>          .phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6190x_ops = {
>>          .phy_read = mv88e6xxx_g2_smi_phy_read_c22,
>>          .phy_write = mv88e6xxx_g2_smi_phy_write_c22,
>>          .phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
>>          .phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6191_ops = {
>>          .phy_read = mv88e6xxx_g2_smi_phy_read_c22,
>>          .phy_write = mv88e6xxx_g2_smi_phy_write_c22,
>>          .phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
>>          .phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6240_ops = {
>>          .phy_read = mv88e6xxx_g2_smi_phy_read_c22,
>>          .phy_write = mv88e6xxx_g2_smi_phy_write_c22,
>>          .phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
>>          .phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6250_ops = {
>>          .phy_read = mv88e6xxx_g2_smi_phy_read_c22,
>>          .phy_write = mv88e6xxx_g2_smi_phy_write_c22,
>>          .phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
>>          .phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6290_ops = {
>>          .phy_read = mv88e6xxx_g2_smi_phy_read_c22,
>>          .phy_write = mv88e6xxx_g2_smi_phy_write_c22,
>>          .phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
>>          .phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6320_ops = {
>>          .phy_read = mv88e6xxx_g2_smi_phy_read_c22,
>>          .phy_write = mv88e6xxx_g2_smi_phy_write_c22,
>>          .phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
>>          .phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6321_ops = {
>>          .phy_read = mv88e6xxx_g2_smi_phy_read_c22,
>>          .phy_write = mv88e6xxx_g2_smi_phy_write_c22,
>>          .phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
>>          .phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6341_ops = {
>>          .phy_read = mv88e6xxx_g2_smi_phy_read_c22,
>>          .phy_write = mv88e6xxx_g2_smi_phy_write_c22,
>>          .phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
>>          .phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6350_ops = {
>>          .phy_read = mv88e6xxx_g2_smi_phy_read_c22,
>>          .phy_write = mv88e6xxx_g2_smi_phy_write_c22,
>>          .phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
>>          .phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6351_ops = {
>>          .phy_read = mv88e6xxx_g2_smi_phy_read_c22,
>>          .phy_write = mv88e6xxx_g2_smi_phy_write_c22,
>>          .phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
>>          .phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6352_ops = {
>>          .phy_read = mv88e6xxx_g2_smi_phy_read_c22,
>>          .phy_write = mv88e6xxx_g2_smi_phy_write_c22,
>>          .phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
>>          .phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6390_ops = {
>>          .phy_read = mv88e6xxx_g2_smi_phy_read_c22,
>>          .phy_write = mv88e6xxx_g2_smi_phy_write_c22,
>>          .phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
>>          .phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6390x_ops = {
>>          .phy_read = mv88e6xxx_g2_smi_phy_read_c22,
>>          .phy_write = mv88e6xxx_g2_smi_phy_write_c22,
>>          .phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
>>          .phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
>> };
>>
>> static const struct mv88e6xxx_ops mv88e6393x_ops = {
>>          .phy_read = mv88e6xxx_g2_smi_phy_read_c22,
>>          .phy_write = mv88e6xxx_g2_smi_phy_write_c22,
>>          .phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
>>          .phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
>> };
>>
>>> Vladimir, as far as style I have no objections moving to straightlined
>>> if's. I most prefer to follow the convention the rest of the code follows
>>> and can change my patch accordingly.
>>
>> Yes, so my objections have to do with code style and with the structure
>> of the commit message.
>>
>> It should have been a more linear description of: user impact of the
>> problem -> identify the cause -> why the existing mechanism to prevent
>> the issue does not work -> what can be done to resolve the problem ->
>> see if this is consistent with what is done elsewhere -> why the
>> proposed change does not break other things -> optionally consider
>> alternative solutions and explain why this one is better.
>>
>> Basically be as preemptive as possible w.r.t. questions that might be
>> crossing readers' minds as they read the commit. You should view any
>> clarification question you receive during review as a potential
>> improvement you could make to the commit message or comments.
>>
>> Also, the commit title should focus on what is being fixed from a user
>> impact perspective. And the Fixes: tag should normally be a single one,
>> which coincides with what 'git blame' finds (corollary: bugs which have
>> no user visible impact are not treated like bugs, and are fixed as part
>> of the "net-next" tree).
>>
>> Also, there should be no blank lines between the Fixes: and Signed-off-by:
>> tags. And the next patch revision should be generated with git
>> format-patch --subject-prefix "PATCH net v2" to clarify it is targeted
>> to the https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
>> tree for fixes. See the warning here (Target tree name not specified in
>> the subject).
>> https://patchwork.kernel.org/project/netdevbpf/patch/20240116193542.711482-1-tmenninger@purestorage.com/
>>
>> The space beneath the "---" line in the formatted patch is not processed
>> by git when applying the patch. You can use it for extra info such as
>> change log compared to v1, and a link to v1 on lore.kernel.org.
> 
> Thank you for all the feedback.
> 
> Since there's the other thread, am I to follow through with this patch?
> 
> If so, I'll clean it up and resubmit (should it be the same thread or
> a new one?).

Your original approach IMHO scales better and is consistent with other 
parts of the code, it simply lacks a better commit message as pointed 
out by Vladimir. Andrew being both a DSA subsystem maintainer and 
mv88e6xxx driver maintainer might see things differently however.
-- 
Florian


