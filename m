Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CA77FC169
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjK1Q1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjK1Q1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:27:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B781C98
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:27:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D12C433C8;
        Tue, 28 Nov 2023 16:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701188834;
        bh=aK3/21f9RdYQmcl78FRdiNXVmir4FYYt7jy6fX2hIpg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XFWHfHx5ueIQ0Tg3EIGPSyC7hgzi/Jb+ytpkcUDYu3ppS3nmkvWds7wqI9z7dRVcv
         wqtgM/4geSq5d9Dx57DkPryfc0Vc9TbJX/wQEFuyy2COHIBYEkUBcuA+fgB6McUwG2
         79TqcJTuYyZwXlkF/fFa+C2B/W+atrX2ecSTWUMLJBiIAbnu1dqxZYGSepbOM7leei
         2Ati39yHhzabrAgw7BSTTAAEXsiX4tMvaBrM59ZFYGkFQ0iBScxMDL/qVwsGKMqJOk
         j71ETCHZKJgvr6s+ESmFYnqXHFJUZVAbz/7YJ28YU9GfDhOMwUoIYyN/Ye9bKwCalj
         Ra9G7fV0xue1w==
Date:   Tue, 28 Nov 2023 08:27:12 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani <hgani@marvell.com>,
        Vimlesh Kumar <vimleshk@marvell.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        "mschmidt@redhat.com" <mschmidt@redhat.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh B Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [EXT] Re: [PATCH net-next v1 1/2] octeon_ep: implement device
 unload control net API
Message-ID: <20231128082712.223c4590@kernel.org>
In-Reply-To: <PH0PR18MB4734281BD887FD9AFD64B2DEC7BCA@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20231127162135.2529363-1-srasheed@marvell.com>
        <20231127162135.2529363-2-srasheed@marvell.com>
        <20231127184306.68c2d517@kernel.org>
        <PH0PR18MB4734281BD887FD9AFD64B2DEC7BCA@PH0PR18MB4734.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 04:22:11 +0000 Shinas Rasheed wrote:
> > On Mon, 27 Nov 2023 08:21:34 -0800 Shinas Rasheed wrote:  
> > > Device unload control net function should inform firmware  
> > 
> > What is "control net" again?  
> 
> Control net is just a software layer which is used by the host driver
> as well as the firmware to communicate with each other, given in the
> source file octep_ctrl_net.c and the corresponding octep_ctrl_net.h
> interface, which is already part of upstreamed driver.

Yes, I think it went in before I had time to nack it.
I'm strongly against using the IP stack to talk to FW,
if you read the ML you would know it.

No new patches to octep_ctrl_net will be accepted.
