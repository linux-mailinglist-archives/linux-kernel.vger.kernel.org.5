Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761787CA7F0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjJPMZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjJPMZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:25:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42D09B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:25:15 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GC9LJj032458;
        Mon, 16 Oct 2023 12:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fdcwLYfEwBvh7hI+Y9HX4exVIEYBwd62Voxgu8myEl4=;
 b=mndzkDvGndyO/dSa1kqlUVw5seS6/PcD3FT83yl4Py78LZ5G+hxxl9F5l2rQTjzh8d4/
 tE0xJqTuOrugDOhxsa2k2XgpR8VSv0/sYy0LAB+JoU0Wx9oXocyzTDzy64aY2O72ekhc
 dPbfQQKLMdenZ4BN1XEw5onknNrbfh2jrY2eVYzy+NVTajKSr29fH6zRbYIpP0BRBewh
 Gj5bYmB2YxVHwnc9Ls83jDfo85u2IQRqc7piBLrdfMvaoLBbR3amtEHe2mUTVvPLGB9O
 ueTWGlHxjoTGta6LSa3PLUrg/yMLfNrgaTB5uTh8lsjZmhvqo2yH3eXVuN0Wba6BCHUC EA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ts4721xr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 12:25:02 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39GCA8Yn006610;
        Mon, 16 Oct 2023 12:25:02 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ts4721xqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 12:25:02 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39GABk2O027177;
        Mon, 16 Oct 2023 12:25:01 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr6tk0hh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 12:25:01 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39GCP0s520447894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 12:25:00 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 629FA5805E;
        Mon, 16 Oct 2023 12:25:00 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2733D58055;
        Mon, 16 Oct 2023 12:25:00 +0000 (GMT)
Received: from [9.61.111.173] (unknown [9.61.111.173])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 16 Oct 2023 12:25:00 +0000 (GMT)
Message-ID: <df9cffef-ef00-4e52-9df1-8bed3605a014@linux.ibm.com>
Date:   Mon, 16 Oct 2023 07:24:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] regulator: core: Convert warning to debug print
To:     Mark Brown <broonie@kernel.org>
Cc:     joel@jms.id.au, eajames@linux.ibm.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, lakshmiy@us.ibm.com
References: <20231012174235.2424670-1-ninad@linux.ibm.com>
 <aa596890-d98a-41c2-bc10-8c1db58ea23a@sirena.org.uk>
 <4ecd19e5-9dfa-4157-9384-92c722064b2e@linux.ibm.com>
 <ZSlkWZvtEFfSkqNE@finisterre.sirena.org.uk>
Content-Language: en-US
From:   Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <ZSlkWZvtEFfSkqNE@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fyK7-KQBRPzE2rUnlM_n_b6QH6SNrbHu
X-Proofpoint-ORIG-GUID: Ez4TQhk1CPylMHcBuIdQG6ARH3fMYdwL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 mlxlogscore=928 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310160108
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On 10/13/23 10:38, Mark Brown wrote:
> On Thu, Oct 12, 2023 at 04:45:48PM -0500, Ninad Palsule wrote:
>
>> You are right there are regulators for these supplies but they are managed
>> by the
>> hardware hence not added in the device tree. I checked dts/aspeed directory
>> and
>> non of the machine has “vcc-supply” defined and lot of them use eeprom.
> Fixed voltage regulators can be used for this.
ok, So far we don't need it.
>
>> Also, I thought that this message is only useful in the lab to indicate
>> developer
>> whether they missed the device tree definition or not but its not useful in
>> the
>> field.  Hence proposed to put it under DEBUG.
> The theory is that it shouldn't come up in the field since people see it
> during development and fix things then, are people actually looking at
> these logs?  I think my understanding was that they're mostly BMCs
> people interacted with via a UI of some kind.

During testing people look at this logs. We will ignore this warning for 
now.

Thanks!

~Ninad

