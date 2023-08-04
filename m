Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD8B77064C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjHDQt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjHDQty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:49:54 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7853C25
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:49:53 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-403ea0a50f7so16195201cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691167792; x=1691772592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LkUL2PlOzfT58q9qudjtzFzvb7OK02mCRFsTl32ovnU=;
        b=kUyybcKNzzLZ7ehNjnqiw18cmIQMfGtVGlv/zhCpGofq95hPLktzHm0FWZ0gMitYpx
         yL+BC6jbA3nUwlUG4S4mDOVQsSdrkhbr6jgrXYwC5ezRKdka6S3+ySUnpYtgwvvuYGCG
         aadp/6aNQzJOZ62ymVGZjgtzBoPTTHTEfz1FGnzQb42Sz4BArQ4bPFLvsqsu9auDdPt/
         aK63jDpd5hyPPpGb0G7+L+7ruCHNtEtcBi77gJMLKEaLy2eTQyaMy3k5XJWpqnj2r5Y9
         gP2Hder6QnLQy90m4zXSFcRdTkSHHgrr9TImCthlq18CvvVkSPyW8VOoHvGkXtQm3s6n
         QlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691167792; x=1691772592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkUL2PlOzfT58q9qudjtzFzvb7OK02mCRFsTl32ovnU=;
        b=goonjDyBOsGwnXunZB8LbMiR8BgkLsEl0gUoaGd8x0AiLWrxs0OZfTji2PowkBdVVo
         MQyq8f0M6MnjAprQ863vp20QCjSzHGdHvnO4lOScneDBDrPF1x2PTPd2hP6Zok6zTO4Z
         A7ZX9puaWDVH+4L4K4Vk+HZHxx8YZe5AIbHbxHKah1RRbkXzO8NQJWb/12J05XRzD3Bx
         b9yx0+VQV3JkvBqqpMInAILo9dfpwuF23GTUqDNOE8/ilvjEbBvVykfBnG3LSh4vMFpf
         exzzHrd6Y9Es7hqOKMmExFuMuTnRRvjFaGyCr1HevCIrlJBw2Ka40bAe4Cgbjkn03j3a
         RpwQ==
X-Gm-Message-State: AOJu0YxetcdyXZGiqPa2Hf20DUd4d+1s043Qeb/G1xUem6QDTU4R38j9
        AUpi/ZqJwFSX0aSbTzT6QfLnVg==
X-Google-Smtp-Source: AGHT+IHj+Quw/k2Ut+pAvKfZ2oiDEj8XGnx9S5QXbT4XVTYEsHM+FYwYA29FEaM1sPq0Tck85Et93A==
X-Received: by 2002:ac8:5945:0:b0:404:c430:6695 with SMTP id 5-20020ac85945000000b00404c4306695mr3396490qtz.53.1691167792218;
        Fri, 04 Aug 2023 09:49:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id e7-20020ac84147000000b00403c82c609asm783399qtm.14.2023.08.04.09.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 09:49:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qRxzq-003v4Y-SY;
        Fri, 04 Aug 2023 13:49:50 -0300
Date:   Fri, 4 Aug 2023 13:49:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     tariqt@nvidia.com, yishaih@nvidia.com, leon@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 00/10] Convert mlx4 to use auxiliary bus
Message-ID: <ZM0sLsxnP3PoI0lm@ziepe.ca>
References: <20230804150527.6117-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804150527.6117-1-petr.pavlu@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 05:05:17PM +0200, Petr Pavlu wrote:
> This series converts the mlx4 drivers to use auxiliary bus, similarly to
> how mlx5 was converted [1]. The first 6 patches are preparatory changes,
> the remaining 4 are the final conversion.
> 
> Initial motivation for this change was to address a problem related to
> loading mlx4_en/mlx4_ib by mlx4_core using request_module_nowait(). When
> doing such a load in initrd, the operation is asynchronous to any init
> control and can get unexpectedly affected/interrupted by an eventual
> root switch. Using an auxiliary bus leaves these module loads to udevd
> which better integrates with systemd processing. [2]

Neat, I didn't realize that was a pain point for distros.

Jason
