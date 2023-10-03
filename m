Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48517B5E4D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 02:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238738AbjJCAgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 20:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238618AbjJCAgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 20:36:20 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196CBA1
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 17:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696293377; x=1727829377;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=56bRHO/ETstzmwg90kCUicb/HWKgPMGsIwf14WOAco0=;
  b=G4fSrBYsje43MNdkAZ8r9UQAh4EuR48M6xzyFWCgd2Pxy8Q6Ps8a1KHa
   apL4zfo1VHKNU+ob1UxpeKf3KrcAtmyANjA1p0Nquqe0Si3l/PsFQjoDK
   LFpIF51ox+ry0UAVtDcjgCtgCRDanDA6fiBVztW1mojKc8WycL//Q52dc
   PfOxSDeA6LBQVvk65qhZ34lD4JP2Hli1S9DG8BQ1gFP4siHBYtrM+FhM+
   Q+eMzLsgxWWcpJPZPHmzImxh4u9E9DmeWk7+0TOL6SP1dD9K/yMbM4XjY
   jU95RUT9EmBa0oxlOPEY0fUFAwrW7e7/hYV+inea/toQHuy8XP6QUi1lV
   A==;
X-CSE-ConnectionGUID: 4Tk+tdk3QhyqjJ1+bMo7gg==
X-CSE-MsgGUID: Vq9cs+h0Ti20cPoh29QrYQ==
X-IronPort-AV: E=Sophos;i="6.03,194,1694707200"; 
   d="scan'208";a="245492699"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2023 08:36:15 +0800
IronPort-SDR: MhV3EQ1ZmsJZa4WKg7UdAgDHPpMScSL0NSTzMX+7PXZXAJ8kAQ7e1wQt31lMMt93zjztTVIq/6
 CIXokvTwrQdY61PnEK2dDZH9dMeN2jm0wfmOm3VKgLtzLfaGK/LutZvYi1Y7VKOaSpLAZap0kB
 41rvkIFaGY7DTuNVri6jznoPTnGjgEBh/F87w6//bEnZHBIFZ3j1/MvQEFiS7Ad//gteaJ0tD8
 Hd85EBPeCe+zf7Jo/oz2XU7dqD/JCBOZB+lIhD2UaAGaEo9rxzmtkPWwQV3+Ap/Ls2mOotC6bY
 Hww=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2023 16:48:35 -0700
IronPort-SDR: KdNu8qIN0ISFJhID8hf9phEGnyWU0gBCkaP9IECsZg6B3GiCR1mJ3XTHfqqRaoqda01+L+tdS2
 X111Aj7T9C19e5U8ChfHKXnPz/NUSy5Us/PKSgggkCEV4WeBMxn+stIo/Pl8REcKnS98piEWgi
 L7NPMSjtWrXhq6u8XEegIjcFfzimEgI0WPNdJqXjDqmyH3Q3oWZ/c/mBZ4jT6dcJKmoNjpqQdZ
 zh0aZYU/Y/bbrxUHSLbekPPS8ttDmS/CKHpXhHyup/YXSKnEN9o3u6I4Jv8U4Nrvgp3SWuBxB4
 sM0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2023 17:36:15 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4RzzQR2cVPz1RtVN
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 17:36:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1696293360; x=1698885361; bh=56bRHO/ETstzmwg90kCUicb/HWKgPMGsIwf
        14WOAco0=; b=hrikPHbNTwDpfEkzZbpcc9BTWg5MGm8ZQnUMSwD1PSXBOhqBXhg
        AlGtemoDDHhnuRgonsl1x7iz/bb/I+hBn6jrKJBXwoVBufdY+Andz+mlq8CViyzb
        CwjFqNbZtrXAxYaKrQgKmnckGTRFWqGDY286Kd+MuLifW6xv5hcActwcfK7TFzA9
        SfpNWF98g3ojOPCt1ZwLpZJuysLEeL8q5LeSaMloZzsywzog3oKPg6FOUSr3liSd
        /xgetze/iEP9og1zg/C7y/xBARqMEj+I0ms34vWg35xfEjEl/nnIqZNFWko0X/pN
        o/yO1xqcNRjF4s7o83V7NhlcRlWvYRrRC4A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 46tmchg-R2l1 for <linux-kernel@vger.kernel.org>;
        Mon,  2 Oct 2023 17:36:00 -0700 (PDT)
Received: from [10.225.163.119] (unknown [10.225.163.119])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4RzzQ75LYbz1RtVG;
        Mon,  2 Oct 2023 17:35:59 -0700 (PDT)
Message-ID: <b18388fd-ff86-14cb-45f7-6eb56e4bb60e@opensource.wdc.com>
Date:   Tue, 3 Oct 2023 09:35:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: linux-next: duplicate patches in the libata tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231003080744.69ca4ed0@canb.auug.org.au>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20231003080744.69ca4ed0@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/23 06:07, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
> 
>   0e23330fccd4 ("ata: libata-scsi: Disable scsi device manage_system_start_stop")
>   1cf14228f460 ("scsi: sd: Differentiate system and runtime start/stop management")
>   540bd522a82e ("ata: libata-scsi: link ata port and scsi device")
>   54e5c956a103 ("scsi: sd: Do not issue commands to suspended disks on shutdown")
>   6d62f34a6741 ("ata: libata-core: Fix ata_port_request_pm() locking")
>   7c412cfbeecf ("scsi: Do not attempt to rescan suspended devices")
>   9459518aba7b ("ata: libata-scsi: Fix delayed scsi_rescan_device() execution")
>   cb37013b985e ("ata: libata-eh: Fix compilation warning in ata_eh_link_report()")
>   e4bfeedb3b50 ("ata: libata-core: Fix port and device removal")
>   f215cc816f8f ("ata: libata-core: Do not register PM operations for SAS ports")
>   fdd57890e769 ("ata: libata-core: Fix compilation warning in ata_dev_config_ncq()")
> 

Stephen,

Sorry about that. Will fix this asap.

-- 
Damien Le Moal
Western Digital Research

