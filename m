Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3260808E58
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441933AbjLGRAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjLGRAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:00:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843F410EB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:00:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5EDC433C7;
        Thu,  7 Dec 2023 17:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701968416;
        bh=OLCSibMyzPJyDMrC13IEe5TSwMOpnh1gXITCNgapoEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KUUoG6fG9mLK1UFSbZrdcTkR+0Wx+SUw8Q+NFi7WnYvDWNmVVFkoxsQhgiBtTADca
         WXL9SpxVhqMQs6vGYgRK6kfC20KGyCWfTSEL3PyBNWQHdCJleLujmfVoeLAs2LG8T4
         HI4P3k8BFjiwhYsrjRtieYSvGhLMhkp/oUGZlzHcU7fegu0QxSlfw9GLQ8pVPsfIRr
         Lehjo9Wvmjfpk3uS9/b9lo7/RSbadoBZ7IPJ0Ktfw1RyQ9kMhiYrRydOTazW+ulXlA
         iBfyn5syAEPhvMuZ7ngHhLs7wzVSg7uDEtKjVACZS7ypJ46ZO+QXFfxDEhCp7oj7L3
         7gueV4J4yaE5A==
Date:   Thu, 7 Dec 2023 10:00:12 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Georg Gottleuber <g.gottleuber@tuxedocomputers.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Georg Gottleuber <ggo@tuxedocomputers.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Add sleep quirk for Kingston drives
Message-ID: <ZXH6HOpgBoUlnxFu@kbusch-mbp>
References: <20230920085210.22573-1-wse@tuxedocomputers.com>
 <12d32e8e-e20b-4023-8299-39d2a69c0cd9@tuxedocomputers.com>
 <20231206092420.GA27348@lst.de>
 <c930e543-7dab-4559-95d2-270b8df38f3b@tuxedocomputers.com>
 <20231207152048.GA20561@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207152048.GA20561@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied for nvme-6.7
