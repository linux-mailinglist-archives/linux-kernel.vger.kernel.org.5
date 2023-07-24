Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3B875FC3C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjGXQd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjGXQd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:33:56 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28F410F7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:33:35 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-403b30c7377so27388901cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690216415; x=1690821215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NnRivkG6WM9TRuOMq/cdTmoCpoYS5ZS9UTbUmBQcd1w=;
        b=ggbNxtV8851KGsYP7yv6kkqRILR+/iL0QTDfN1q8EEerW7VSn6NBV5uTn/G3s7s6z2
         aoc0LBPy26Sf5gKv8cSzRGhTDJODzUflKajXlfpFesJcSmNIa5zD0RRoPgNwnS//D2vJ
         YCzgfBA2z7Sv99Vn/T6M0U0RbBMQV69PTObaLSZ7B+U6efWJLtNQNEFiH3x4ByvfmDIo
         2rYXcMVH/kDtoqEBw6bn4+YzhMzDYFIN2sWsMWjnx1oKxVjiDo2K+6N+bvZ6mF3su4XJ
         c4ja2kB8lwJLSJGc/EJFmJwbsYmd+qwrCioga/TStu7Uxmk4TzraCvpaV9+A9fj9sdsw
         HcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690216415; x=1690821215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnRivkG6WM9TRuOMq/cdTmoCpoYS5ZS9UTbUmBQcd1w=;
        b=fStll43Y7exS0wXqB/+hlEBc4sNVHt3NYYccB31P32ohK1WTqs4Jy08RC2zHeD92Kr
         Tw6ZpQ9L8wnZx5PkSzBfTfkaJE76+bHjH0IVqfQ6VlOUt4rIcq9ek+4cFRNHI075ePRE
         OBvfAU2tRTcbUseaVsEL04ybMJrCaWBq/9/MOMN9jgtNVsqqPv0JaMmZmi2R/jJUXuUb
         e8Iu2wafMk/KRnzdTrutv25zX0Ej/RaY8CtfRItnwB1sLFAVv/gtwSyfsyMnA16xlOxd
         mY7QNyQRPTfk5DgXb7jWp6jYtUb/VxTd+ZBW1anaqKtfu0ElaEx1EWjLQ/tQhNfK5Hro
         3OFA==
X-Gm-Message-State: ABy/qLZ0iRYRciVQXJHuaZTuLz8b3sozDi+rQorzBCjJ5O174kXiJ4iD
        nLD6P/qccKQju6D4ynrKkOBzMw==
X-Google-Smtp-Source: APBJJlFQ4LC4JzpGfviU5rQcz0YnPw5yrkA7UPIbmPCdE3MJ+4yOE8vtrkJazMOsR8QKVwaCNT3WZA==
X-Received: by 2002:a05:622a:182:b0:400:938b:eb0e with SMTP id s2-20020a05622a018200b00400938beb0emr277982qtw.43.1690216415053;
        Mon, 24 Jul 2023 09:33:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id w9-20020ac87189000000b00403eab8b7cesm3395763qto.16.2023.07.24.09.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 09:33:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qNyV3-000K4o-R3;
        Mon, 24 Jul 2023 13:33:33 -0300
Date:   Mon, 24 Jul 2023 13:33:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tanmay Jagdale <tanmay@marvell.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        baolu.lu@linux.intel.com, thunder.leizhen@huawei.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, gcherian@marvell.com,
        sgoutham@marvell.com, lcherian@marvell.com, bbhushan2@marvell.com
Subject: Re: [RESEND PATCH 0/4] Add support for SMMU ECMDQ
Message-ID: <ZL6n3f01yV7tc4yH@ziepe.ca>
References: <20230721063513.33431-1-tanmay@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721063513.33431-1-tanmay@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 02:35:09AM -0400, Tanmay Jagdale wrote:
> Resending the patches by Zhen Lei <thunder.leizhen@huawei.com> that add
> support for SMMU's ECMDQ feature.
> 
> I have tested these patches on Marvell SoC that has the ECMDQ
> feature.

Last time this came up Robin was interested in real world performance
gains

Do you have data to share that is motivating you to do this work?

Jason
