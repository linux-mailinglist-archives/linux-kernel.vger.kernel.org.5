Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31599766A0F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbjG1KS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjG1KSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:18:42 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1D83A81;
        Fri, 28 Jul 2023 03:18:40 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36S81FWU025334;
        Fri, 28 Jul 2023 05:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=tDBgLObf4/016fMM1QWZPSekKXx6KyovqNEWCRV3U84=; b=
        CScjMreJt/+dmZa9iBxGEisdzomc6rWsrf+Pt6jRz4tK5KysJ5NqUdkpC58/JKT6
        +AzDIJkifG997m84S28Ly8xt5MDSH8uVVCa1V2iHSJjo7LVFUEYWbmC3DRRb0fyL
        hWx2iFEC0TKZKjMopPxFZQTjY1IFgXjqObhl3aVUj1rdah5dJCRB3NWvg+snjLAo
        A4+NsW/b7r/wTipZxf3ow7W5RAmkFXSDfukREXMVKi18vblgWAknTz35uye7X9zB
        /gDxNToZx4xZtNsdcpjt1DU6lnfZ52Bu0MZsu8csdAuBNcfPkEk8APRO1Yon5b0L
        smHa0fsCa6X0unJrVtCa3w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3s2q713a4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 05:18:30 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 28 Jul
 2023 11:18:28 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Fri, 28 Jul 2023 11:18:28 +0100
Received: from [198.61.65.196] (EDIN4L06LR3.ad.cirrus.com [198.61.65.196])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id ED41845D;
        Fri, 28 Jul 2023 10:18:27 +0000 (UTC)
Message-ID: <42c73f84-620b-471b-0a42-0c1e10798f07@opensource.cirrus.com>
Date:   Fri, 28 Jul 2023 11:18:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] ACPI: scan: Create platform device for CS35L56
Content-Language: en-US
To:     <rafael@kernel.org>, <hdegoede@redhat.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>
References: <20230727103754.9914-1-rf@opensource.cirrus.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20230727103754.9914-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ov3oevn6UMx-QeSkz8s7xbTWbTDwebAe
X-Proofpoint-ORIG-GUID: ov3oevn6UMx-QeSkz8s7xbTWbTDwebAe
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/7/23 11:37, Richard Fitzgerald wrote:
> From: Simon Trimmer <simont@opensource.cirrus.com>
> 
> The ACPI device CSC3556 is a Cirrus Logic CS35L56 mono amplifier which
> is used in multiples, and can be connected either to I2C or SPI.
> 
> There will be multiple instances under the same Device() node. Add it
> to ignore_serial_bus_ids and handle it in the serial-multi-instantiate
> driver.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---

Don't merge this, I've discovered that we need a 5th entry in the
table, so I will send a V3.
