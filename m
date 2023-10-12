Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E7A7C7964
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 00:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443039AbjJLWSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 18:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443017AbjJLWSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 18:18:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64A7DC
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 15:18:47 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CLvSdq013683;
        Thu, 12 Oct 2023 22:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vZaWFe467NA9vHpyizU+95xwYEOfJBJkdIfg6VnPuGA=;
 b=myc4x/4C32syWkymHXJzv2H5yBucDFuDIhX7oQqlNTPaWMWtu4DN5T2tpiPMCZLlBMRx
 t1DYpte/OzFdrKbzCylZi3wqPsxdvtw98XW6mWz0mB6iqx+GJw36VAmY7prd+N+zg/0I
 mZZnZRtv9ed1UGvkfOxCxJHZW+wh8ab0xgLZ6ZUBItxmYseLD/S98PQPLTZFyTunCKmN
 vJH66pG5vgm9Q760aFmz8nEwFJE9Ub0CcYTmAUURLVL9aTx85idaul0IsBglQVpKL9zf
 3QXLoG02dGN2kbqP93y7jny48PGWhiWYQvXss7GcIdddENmTZZ9Qkz1SN/dpvg17nxUq +w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tps5tgjh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 22:18:38 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CMAQYl025426;
        Thu, 12 Oct 2023 22:18:37 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tps5tgjgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 22:18:37 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39CL0mSC000640;
        Thu, 12 Oct 2023 21:45:50 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkk5m2cq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 21:45:50 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39CLjnWW35717492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 21:45:49 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7886B58060;
        Thu, 12 Oct 2023 21:45:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3191158056;
        Thu, 12 Oct 2023 21:45:49 +0000 (GMT)
Received: from [9.61.9.6] (unknown [9.61.9.6])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 12 Oct 2023 21:45:49 +0000 (GMT)
Message-ID: <4ecd19e5-9dfa-4157-9384-92c722064b2e@linux.ibm.com>
Date:   Thu, 12 Oct 2023 16:45:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] regulator: core: Convert warning to debug print
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     joel@jms.id.au, eajames@linux.ibm.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, lakshmiy@us.ibm.com
References: <20231012174235.2424670-1-ninad@linux.ibm.com>
 <aa596890-d98a-41c2-bc10-8c1db58ea23a@sirena.org.uk>
From:   Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <aa596890-d98a-41c2-bc10-8c1db58ea23a@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ur2C_DrL1dzqR1PcoOSAxb7sbw5Vr4nB
X-Proofpoint-ORIG-GUID: w0wfcMLGYo3YhNGWCIKXPw4Qww0g076j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_14,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015 mlxlogscore=858
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120187
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

Thanks for the review.

On 10/12/23 12:47, Mark Brown wrote:
> On Thu, Oct 12, 2023 at 12:42:35PM -0500, Ninad Palsule wrote:
>> There are some boards without the vcc regulators for eeprom or other
>> devices. In such cases, we should not see the following warning and
>> this confuses the user. We want to see this only when it is compiled
>> with CONFIG_REGULATOR_DEBUG option.
>> [0.747347] at24 6-0055: supply vcc not found, using dummy regulator
>> [0.752877] pca953x 6-0074: supply vcc not found, using dummy regulator
> This is a warning saying that the firmware description for the system is
> incomplete in case things go wrong later - it is vanishingly unlikely
> that these devices actually do not require supplies, we'd probably have
> heard about it if they did.  If a supply is not described properly we
> may for example decide to power off what we think is an unused supply
> with bad results.

You are right there are regulators for these supplies but they are 
managed by the
hardware hence not added in the device tree. I checked dts/aspeed 
directory and
non of the machine has “vcc-supply” defined and lot of them use eeprom.
Also, I thought that this message is only useful in the lab to indicate 
developer
whether they missed the device tree definition or not but its not useful 
in the
field.  Hence proposed to put it under DEBUG.

Please let me know if I missed something.

Thanks!

~ Ninad


