Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22C778B2D9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjH1ORs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjH1ORW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:17:22 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DE6103
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:17:20 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5008faf4456so5091217e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693232238; x=1693837038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=znr7jcRrSJ1Rtj66K8AVDTql7nVoIVkV95oWwStm0/Y=;
        b=rXj/RLREkCMeOmmFTqEHO1MePaKjNZOirGnqEMoPdKn/eURsSaLlxCeKxePVKJ+qGt
         +uqH/oZJYdX0B0Q15s2kzDNraQS9EQDJ38mwix3OM6oVglg+6boNjfTpnBauORSs+RW6
         KY/J6Pe3CmyBfvVCzwqViELtWqrRFnH3LB3U2AZrUsV1wgbmtrq0GNskIlOqAmsvwkMj
         JpEazsTojokjE3hk5gDyFuDZJHFi1aBLu5A3BbOTI/Dk0ri92vTzmAOTcGRdhwbJRROx
         9bdURRf4OxODf+0xG5bBGqV9C4V0QnB5OlHRF1fzPBOkG93rMm9gm0SZpkUUoqzbIZJu
         clhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693232238; x=1693837038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znr7jcRrSJ1Rtj66K8AVDTql7nVoIVkV95oWwStm0/Y=;
        b=VTv6BFpvMYJOhzoeFFPj3/+NJnOFs8UKy2bANWqB6SSGEsrYYj5I+o1X74I/yOjJhu
         z7ONE4meMyaIg7JPRevds1X1caM+4Ieswvr4FrypgbfEp3WCGSVvAV8xtOsxbJTIN0pX
         m8f3wTsNlET5OrQhVN7B3HVTv2VIuBsEzBUHsbZY89UMv8mzy3+UxlWl+pGOAybiy/BX
         g9GN0+W7Oisdag/EH1phTq+ci9AoIBArewiL9zS0U1JBPGhGk6fhCphm7UTPOszIQijP
         9McCNkYf+4uEaM1/xrYynu/6t5xp3VfC4jxhvmVlwl6e3kD1TH+cxfuy/hx+dD2mNVky
         GksA==
X-Gm-Message-State: AOJu0YwQPUcMXMdvHGVcoTjxApdcWPFk/YeMLqavAqhoal1TiUUVX4ar
        Y5ootP0U7YG7/DaBUCKbza0=
X-Google-Smtp-Source: AGHT+IGUpROOCsmb9my59ywO3DgU8ggD7WyvJYhxzdr19qAh981l8KPVz1/jicIv3oTHCgX+JHJC6w==
X-Received: by 2002:ac2:551b:0:b0:500:9a29:bcb0 with SMTP id j27-20020ac2551b000000b005009a29bcb0mr9735911lfk.42.1693232238074;
        Mon, 28 Aug 2023 07:17:18 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id n25-20020a05640206d900b0052a1c0c859asm4509324edy.59.2023.08.28.07.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 07:17:17 -0700 (PDT)
Date:   Mon, 28 Aug 2023 16:17:16 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Oliver Crumrine <ozlinux@hotmail.com>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v4 0/6] staging: octeon: clean up the octeon ethernet
 driver
Message-ID: <ZOysbIihBA5ZMGc9@nam-dell>
References: <PH7PR11MB7643280D48E45D2B660F5B6CBCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB7643280D48E45D2B660F5B6CBCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 09:39:13AM -0400, Oliver Crumrine wrote:
> Make the octeon ethernet driver better conform to the linux kernel coding standards
> 
> Oliver Crumrine (6):
>   staging: octeon: clean up the octeon ethernet driver
>   staging: octeon: clean up the octeon ethernet driver
>   staging: octeon: clean up the octeon ethernet driver
>   staging: octeon: clean up the octeon ethernet driver
>   staging: octeon: clean up the octeon ethernet driver
>   staging: octeon: clean up the octeon ethernet driver
> 
>  drivers/staging/octeon/ethernet.c     |  6 ++--
>  drivers/staging/octeon/octeon-stubs.h | 50 +++++++++++++--------------
>  2 files changed, 28 insertions(+), 28 deletions(-)
> 
> -- 
> 2.39.3
>

The patches themselves should also be sent with this cover letter. Instead they
are sent in a different thread :(

Best regards,
Nam 
