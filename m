Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5FF758C29
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjGSDcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjGSDbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:31:42 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857731FF7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 20:31:09 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 457FC37F84;
        Tue, 18 Jul 2023 23:31:08 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=5JrGZau5Te0aA9tX7zgFjqmPAJmWGdldNLvKmAk
        CJEU=; b=P88U2hJTSg4z5EIL9YcQfoJtJ0KGXZWt1nzvdkOieEtoEaLp0aHpGAf
        cbOpjpgx8Ua/a2vhejWEtjt0BW25qyItRWldcEXGsHKr/dX5WqLhWWqG/+cDw0Jj
        BM3/MJP1dN5BeKYLcpsv9ZFsty9TCGiuoHjdr+TUadVVedIhoWgk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3E48737F83;
        Tue, 18 Jul 2023 23:31:08 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=2019-09.pbsmtp; bh=5JrGZau5Te0aA9tX7zgFjqmPAJmWGdldNLvKmAkCJEU=; b=IwTtyUgW97kvKKIDi11VyfIKsstYbv9ELIbdjL2KY6JdXY6it+E8DchLyAqCdROpTG9zzDVEcSij75JIPUpZjK+Gd1IUAjeo3gqjxyCWJQMMi0e7/TbOpoYY3CdGgCEDBkoD10+FI4wLaqKYWFDE5Wpj3Y7OH1eo5rKGLbes5EI=
Received: from basil (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 49BFC37F82;
        Tue, 18 Jul 2023 23:31:04 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Tue, 18 Jul 2023 20:32:04 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     gregkh@linuxfoundation.org, dan.carpenter@linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Rename variable bCurrentHTSupport
Message-ID: <ZLdZNNs/NlbWAFCP@basil>
References: <ZKYgH/BvkE9bdcPm@kimchi.darkphysics>
 <6dee04ae-4129-cd7c-0d31-70d29b86c8ff@gmail.com>
 <ZLL+Q0tcW5S8Xjmj@basil>
 <95e0287d-3211-3c0d-7a52-740acdb75f45@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95e0287d-3211-3c0d-7a52-740acdb75f45@gmail.com>
X-Pobox-Relay-ID: B0CD2C7E-25E4-11EE-9E12-C2DA088D43B2-45285927!pb-smtp20.pobox.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 09:56:24PM +0200, Philipp Hortmann wrote:
> On 7/15/23 22:14, Tree Davies wrote:
> > Philipp,
> > 
> > I think I understand what I did wrong. Each of these original patches were
> > created/based from the same commit hash. So it makes sense that only the
> > first one applied would apply cleanly and the others would fail.
> > 
> > My apologies,
> > Tree
> 
> Hi Tree,
> 
> you could work this way if you ensure that each patch does not modify code
> (and some lines above and below) a previous patch modified. But it is not a
> good way to do so. Existing tools assume that you create your commits onto
> each other and then make patches out of them.
> 
> Another issue right now is that approximately 18 patches send in and are
> possibly applied (for rtl8192e). Your patches need to fit onto those
> patches. Otherwise they cannot be applied and will be rejected.
> 
> Typically Greg applies all patches once a week. But it seems that he has a
> bunch of other more urgent tasks. So you need to focus on other kernel
> related task like educate yourself or prepare patches without sending them
> in.
> 
> Thanks for your support.
> 
> Bye Philipp
> 

Thnaks Philipp,

No worries, I'm patient, and happy to help any way I can. 
I have hardware coming in the mail this week! I already have  
3 mPCIe rtl8192e devices, but I am waiting on the PCIe adapter card for
my test machine.

I'm stoked. :)
Tree


