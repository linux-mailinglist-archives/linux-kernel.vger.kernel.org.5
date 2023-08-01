Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6554A76B474
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjHAMN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjHAMNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:13:25 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C491990
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 05:13:23 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe167d4a18so33149995e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 05:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1690892002; x=1691496802;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=2Bg3vuHDK1chesb8Cvwh0EPT81VwLYoy6o1zjsPyDao=;
        b=E6qw1wML4+ZXUwDdL1Ej+y95ntDPygJiIhKDTHKYrn41FGkIC7CN++dKrHWleWOVPB
         afucCNg7x1yucKeOqzafkDMo/yB2zMetdAl28+Ze26wP2fCJPiEx6RtzH2GHCotEQp20
         RQs1S5dP633qmtjFXFkeBtZWd0iBp9dLqG4Fi2HaeH5+3w/kGdCL8pTy29U02UM9n7aC
         +Dy1jJP6vRZ7Qpv2xMXp61YVqQ41Qn7DCpMFyuepijOGA29yjAQHllouccd+A0MrGgF4
         N/RmI+Ld4oCJZ2kG5oZoqn6sKDvviQcx30dHe8986ow7E4xwfvWBTEzHhugVDtELk2Ju
         DAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690892002; x=1691496802;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Bg3vuHDK1chesb8Cvwh0EPT81VwLYoy6o1zjsPyDao=;
        b=N6Uosuobqbgkx/MJqUi1yrYtVhNFkbXhvCYHQQ8O22IgQJAQZHKUJ8OHg6rkfSRD93
         oFoZbLFJ4gjKIpe3geKlIs42N2MM1iIGSXMeptkNPgeym5ntzhNbdezbDnpY/m7wbbNz
         xA2YrkcKhPljIzZwBuR4fipDDetmbDTcJprzlkZ3ACa1v2gbYTy1aQxEFp2JNmO4cKD4
         2ITwkMUJfVndmq2EjB1+FL0U61vCSajjyqLD6Gex+mzNHh2jf+Z5k1lsszKp9Xz1Y2hF
         sYW1Q7lgb2jSKXUhK3Cu771mJL1315Z/jExDeFzb3uWwJlF7rEVvdeAkz+Epc9wtJ7Fi
         Foug==
X-Gm-Message-State: ABy/qLZ0dROcZgUwKYFJ7v8JqpizAfdXbykCfLcGHZZKwy4cbYFi08jn
        4G9I6lTSZzYyi+hGqdHqcm22/w==
X-Google-Smtp-Source: APBJJlECZozkp1Tnu+B2GrFE1jQBQCJFjyh4uah59/l6lR7k4sjW/vX6KGmGr0KKf1ydPTPAryCLVQ==
X-Received: by 2002:a1c:6a0e:0:b0:3fd:2e89:31bd with SMTP id f14-20020a1c6a0e000000b003fd2e8931bdmr2347615wmc.14.1690892001367;
        Tue, 01 Aug 2023 05:13:21 -0700 (PDT)
Received: from localhost ([147.161.155.108])
        by smtp.gmail.com with ESMTPSA id w17-20020a05600c015100b003fbfef555d2sm16518134wmm.23.2023.08.01.05.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 05:13:20 -0700 (PDT)
References: <20230714072510.47770-1-nmi@metaspace.dk>
 <20230714072510.47770-3-nmi@metaspace.dk> <ZLfQjNK5j5lB68C/@x1-carbon>
User-agent: mu4e 1.10.5; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Matias =?utf-8?Q?Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH v9 2/2] ublk: enable zoned storage support
Date:   Tue, 01 Aug 2023 14:11:56 +0200
In-reply-to: <ZLfQjNK5j5lB68C/@x1-carbon>
Message-ID: <87il9zot9c.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Niklas Cassel <Niklas.Cassel@wdc.com> writes:

> On Fri, Jul 14, 2023 at 09:25:10AM +0200, Andreas Hindborg wrote:
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>
> Hello Andreas!
>

<snip>

>>  	/* for READ request, writing data in iod->addr to rq buffers */
>> @@ -1120,6 +1404,11 @@ static void ublk_commit_completion(struct ublk_device *ub,
>>  	/* find the io request and complete */
>>  	req = blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
>>  
>> +	if (io->flags & UBLK_IO_FLAG_ZONE_APPEND) {
>
> Do we really need to introduce a completely new flag just for this?
>
> if (req_op(req) == REQ_OP_ZONE_APPEND)
>
> should work just as well, no?

Makes sense, thanks.

BR Andreas

