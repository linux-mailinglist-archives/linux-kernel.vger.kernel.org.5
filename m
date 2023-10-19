Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48357CFC7E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346083AbjJSO2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346086AbjJSO2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:28:08 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B70189;
        Thu, 19 Oct 2023 07:28:05 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d9a7a3e17d1so9330166276.2;
        Thu, 19 Oct 2023 07:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697725685; x=1698330485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oBMpoyva4vl1WYLwrQEM86CCdZibJLAIkHQxuLCt39w=;
        b=J2hnKkqur7ibUKV8S1SCpQrulpgOYNU8uBCm218d47KxD/7VFnz8x/q90p5x4tn0/s
         fxqD6qH/5uVmqA5mNINfvYkU/6S2nAzcmesSqVH4ulEzm7tz0cgUAL0zTxCA0rs7fXJm
         zc00g3sjBHPIsKaguSltmmKohlf1CvWEDQ0bwK2VXztGzfuaEKlO2RFTp6+cMiISExII
         vPtN0NDQAPAziNQNibeizM/EqV14jihvK4/oNybk4CjfCQStSN1HRSjVVzqA7ES3hg24
         zlLjdpedE99TVEJTPdQvs4QKpMz2vStw2Ht0Vrrne8wLPXnWtrDVsg0A7no7B+rXPbGu
         7+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697725685; x=1698330485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBMpoyva4vl1WYLwrQEM86CCdZibJLAIkHQxuLCt39w=;
        b=OY9IOz1EUSK0Ob4wtfaFU03ryfAva5JJGYlWeyAyS84RmCzGREbkjKEnxqOeeNWWX0
         35nFEl7YJWADP7Wg8mSgel0aninvDGGykRwxGGd1ycpOfCBNJ03r5xTrzo5TNhIEQl0C
         e8BT+6kEPJv67OOWmPgb4vx7VZwKeRzuThYIzfqudOntK6vYXZ8FjISFsYv6RKMS49m6
         PolN/x6pIVxGk1dAIqHByWLkTxCxfbgBGmBnr/IaqWej1unfrJGItWjta8ErFw4lbZqG
         AMtlnejlLipvbljjeGXsOmyYxxNhacrOvKmSHiaww237cAJj6ClBPpJwq+E2tl1rnQ8b
         xBtQ==
X-Gm-Message-State: AOJu0Yze/9tFzH6Q+sykkXIK5rkXpQ7QvjaH6GmeUzpS1m/1Jb3Xf3e+
        8kx/z0m13fWPVD5s4u7Xxm2wKrI1StVC9g==
X-Google-Smtp-Source: AGHT+IGRM7KqfY5SHNFk503Wz2rQrxExX77omLZ0a0zHhWZO1QvrPGH/BlBWfUmXbRCdZOCwOLUM6g==
X-Received: by 2002:a25:8a0b:0:b0:d9b:4c61:26f1 with SMTP id g11-20020a258a0b000000b00d9b4c6126f1mr2375244ybl.24.1697725684902;
        Thu, 19 Oct 2023 07:28:04 -0700 (PDT)
Received: from localhost (modemcable065.128-200-24.mc.videotron.ca. [24.200.128.65])
        by smtp.gmail.com with ESMTPSA id q8-20020ac84508000000b0041cb8732d57sm769355qtn.38.2023.10.19.07.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 07:28:04 -0700 (PDT)
Date:   Thu, 19 Oct 2023 10:28:03 -0400
From:   Benjamin Poirier <benjamin.poirier@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Coiby Xu <coiby.xu@gmail.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        George Cherian <george.cherian@marvell.com>,
        Danielle Ratson <danieller@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Brett Creeley <brett.creeley@amd.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Aya Levin <ayal@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: Re: [PATCH net-next v2 10/11] staging: qlge: devlink health: use
 retained error fmsg API
Message-ID: <ZTE884nkvAxKy2G3@d3>
References: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
 <20231017105341.415466-11-przemyslaw.kitszel@intel.com>
 <20231017181543.70a75b82@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017181543.70a75b82@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-17 18:15 -0700, Jakub Kicinski wrote:
> On Tue, 17 Oct 2023 12:53:40 +0200 Przemek Kitszel wrote:
> > Drop unneeded error checking.
> > 
> > devlink_fmsg_*() family of functions is now retaining errors,
> > so there is no need to check for them after each call.
> 
> Humpf. Unrelated to the set, when did qlge grow devlink support?!
> 
> Coiby, do you still use this HW?
> 
> It looks like the driver was moved to staging on account of being
> old and unused, and expecting that we'll delete it. Clearly that's
> not the case if people are adding devlink support, so should we
> move it back?

AFAIK this was done by Coiby as an exercise in kernel programming.
Improving the debugging dump facilities was one of the tasks in the TODO
file.

I moved the driver to staging because it had many problems and it had
been abandoned by the vendor. There might be some qlge users left but is
that reason enough to move the driver back to drivers/net/ if there is
no one who is interested in doing more than checkpatch fixes on the
driver?
