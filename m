Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FBA75E04B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 09:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjGWHgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 03:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGWHgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 03:36:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CC81722;
        Sun, 23 Jul 2023 00:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690097774; x=1721633774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FXpkpHGvjcN8pNV3Eo50b5Sdk82SFe2XZq1g4308TdA=;
  b=LeBh9BrpTMKxeIYVywTvBXvO3Qw2u1dGY77vH4spxAJLF+NwmiAMzvgs
   EkpmM2hNLYIlp/OsEGChVLxWsTv3uPxio7uc2R8S+JUIlVdvj1OXrFVjy
   9fOQ/nV7RpIGw9J4AUbmCvg1qAaZMQc/6GMOAWzpw9OpxhMCvmyiEfKuI
   I4OitmepAgjSxcsEJDW0e5cVbUBcst4hgIGEFk1V41GpT8MktL1tfo0zd
   v4YaBdClX+gwCpl+Q6x7fM3xeFfx8kXGgcNBmX7P/huEBdteakMDchfB4
   H2YCCvjZHzE29xVtV9Q1K1p45NEZJjf3b5Numl/BXsaFTWFxzjzDsPgW8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="453633085"
X-IronPort-AV: E=Sophos;i="6.01,226,1684825200"; 
   d="scan'208";a="453633085"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2023 00:36:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="760436357"
X-IronPort-AV: E=Sophos;i="6.01,226,1684825200"; 
   d="scan'208";a="760436357"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga001.jf.intel.com with ESMTP; 23 Jul 2023 00:36:05 -0700
Date:   Sun, 23 Jul 2023 15:34:19 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH v10 1/4] fpga: add an initial KUnit suite for the FPGA
 Manager
Message-ID: <ZLzX+xZWaiMfslTo@yilunxu-OptiPlex-7050>
References: <20230718130304.87048-1-marpagan@redhat.com>
 <20230718130304.87048-2-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718130304.87048-2-marpagan@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-18 at 15:03:01 +0200, Marco Pagani wrote:
> The suite tests the basic behaviors of the FPGA Manager including
> programming using a single contiguous buffer and a scatter gather table.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>
