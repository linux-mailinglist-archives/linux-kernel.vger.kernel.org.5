Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7CF803597
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbjLDNyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbjLDNyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:54:35 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8169A10E;
        Mon,  4 Dec 2023 05:54:38 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B48WiWV016031;
        Mon, 4 Dec 2023 07:54:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=7Cszo/QfiEGpR/7BrzRb15GLRpfykFiy+y4Fq2bL4dg=; b=
        X8UxyoNpRiT0DK3Jlgppd805lWxAeFYRgFrMhQgn33o3tOYK3MPCv6EeA4r53Pje
        ZfIuDbCLU3nSPK3FEKEa1s3xoPmn+3ztl4IBO7HyD29XBZgAkrDviwFiphl7NwIv
        ryq7V4+yiNmK105vzMuIkDb3uxWd6EOpp1IwkbNKkPWXD8JcR51xkLTUGCmhCYN4
        /DF4MTujDfeZZuTJ59y/pILLuJxL3WseMs/R6gAouTJBNNmOZav+1VpPLE6gzTzV
        FbDrn7klBlKpy2C5dflMm395+G8OzBpfwaKeFX8xWHikaFq9q7S8L8LnVjpaDQ5N
        9JCSY8RL3jqZIaPC+PB7Fw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ur1vnhxkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 07:54:18 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Dec
 2023 13:54:16 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Mon, 4 Dec 2023 13:54:16 +0000
Received: from [198.90.251.82] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.82])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5572C468;
        Mon,  4 Dec 2023 13:54:16 +0000 (UTC)
Message-ID: <e93d5d7f-3e60-4577-b2f9-dfe73ef757b1@opensource.cirrus.com>
Date:   Mon, 4 Dec 2023 13:54:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: Intel: soc-acpi-intel-tgl-match: add cs42l43 and
 cs56l56 support
To:     <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>,
        <peter.ujfalusi@linux.intel.com>, <yung-chuan.liao@linux.intel.com>
CC:     <kai.vehmanen@linux.intel.com>, <cezary.rojewski@intel.com>,
        <ranjani.sridharan@linux.intel.com>, <alsa-devel@alsa-project.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20231204135307.2169282-1-rf@opensource.cirrus.com>
Content-Language: en-US
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20231204135307.2169282-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: PaX3Q-Tak9cV3HoZ9I-gNyTEhTPutX0O
X-Proofpoint-ORIG-GUID: PaX3Q-Tak9cV3HoZ9I-gNyTEhTPutX0O
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2023 13:53, Richard Fitzgerald wrote:
> From: Bard Liao <yung-chuan.liao@linux.intel.com>
> 
> This is a test configuration for UpExtreme with Cirrus Logic
> CS35L56-EIGHT-C board.
> 

Please ignore this. I've just noticed the typo in the commit
title (carried over from V1). I'll send a V3 with this corrected.
