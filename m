Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A4977CA64
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbjHOJZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236206AbjHOJZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:25:33 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C25AA6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 02:25:32 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37F6wSJa022796
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=yUkxk45vSvGqqSJrwbVbenrykpsk5A2DKnwbhXUzYDQ=; b=
        meb9A24UdHa7yfzl2akm2uWkC0aq7SOl1AC2I/ueeMaihPv6cSy0gy0YMqVfQyQa
        Stu/ZDEZqDrd49isf65WphV9lU0twWh2oKmdI6mxqNXloNyvV9nvQycJPG3jZ7mf
        fcIK2/zXQ9Txa7yCljMy4wpRqmwq8UGNTLzVz2iz5oeeZS1cXlYZxaPr06FlF630
        MEGKFFAGkJenzyuoG+YGuWX3X9eCtSZVOwGtNxMoJETCVupJ7ShWbH3qv4DbgvvH
        x33nciDZAQ6J1ef2iztwTUO7xWBWwnN7GWZ3gxqdg2udSxZweowLIR/X9mbcxnPC
        ArYgBURoV9O2mP1q7EAFdg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3se8kqua0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:25:31 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 15 Aug
 2023 10:25:29 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Tue, 15 Aug 2023 10:25:29 +0100
Received: from [198.61.65.68] (EDIN4L06LR3.ad.cirrus.com [198.61.65.68])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C9A4911AA;
        Tue, 15 Aug 2023 09:25:28 +0000 (UTC)
Message-ID: <39455d8a-6226-2ca6-b289-cf6e61aac413@opensource.cirrus.com>
Date:   Tue, 15 Aug 2023 10:25:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] firmware: cs_dsp: Fix new control name check
Content-Language: en-US
To:     Vlad Karpovich <vkarpovi@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
References: <20230804165212.236822-1-vkarpovi@opensource.cirrus.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20230804165212.236822-1-vkarpovi@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 9i8qMCa6U1xtBDmJwNyYXnDnl8nEgkN9
X-Proofpoint-GUID: 9i8qMCa6U1xtBDmJwNyYXnDnl8nEgkN9
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/23 17:52, Vlad Karpovich wrote:
> Before adding a new FW control, its name is checked against
> existing controls list. But the string length in strncmp used
> to compare controls names is taken from the list, so if beginnings
> of the controls are matching,  then the new control is not created.
> For example, if CAL_R control already exists, CAL_R_SELECTED
> is not created.
> The fix is to compare string lengths as well.
> 
> Fixes: 6477960755fb ("ASoC: wm_adsp: Move check for control existence")
> Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
> ---

You need to send this to Mark Brown.
