Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FD97F2BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbjKULbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKULbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:31:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D09E9C;
        Tue, 21 Nov 2023 03:31:18 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALB9omS032151;
        Tue, 21 Nov 2023 11:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=wBEXCSIf+PTXF3Jmbs0xUj4Xtu0nvei3kKdqszcmHrE=;
 b=msEjNvKU3teikpgYYd7JEr7xVVDAbTWNfmpHkJz/jgIWu+kQhB52ecbva+YcdOJG8NJI
 3/OH3hCngcfnpooKtOepHYLYki9zyNxZQCYD8PNfgM34sbiPtjsElcvf1sDv+5k4f7S8
 cALjEHSk8ZSZljW56iz+5J3udbiRTnojD2thiGRj79rX6Omg4tVKxFvsd3lqV9tdy794
 0l28tq9rruzrFljFDeBvVMHVEzYKngCLnXOJLfBKkaHDH4lRBF6DjSS4PPEyKG9uLaD9
 s6DRM+9qvVlroEufOdnIxMw6f/nNGAOd33dwzhaQ613VQvmtMEDCoJu9+s99VRJZ2B12 Pw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uentvcu7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 11:30:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALBD1pE031239;
        Tue, 21 Nov 2023 11:30:58 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq6ws4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 11:30:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+8G5CJLAHt4h3tjt/eo01/zm9cMb798FjifsI5q4kGvAi/NRofuCHVJTdvx7DGxLqRMLjOg+YON3NbShcgBhvIPz3lXm7YogR1lVcBVAGlfud5chGq+bHSHVwMTtHfy4xpxKNhOCYspWXlGSwsIleM1PrEWTTTRRBZzW7S7ePMMbWdxvoxYpZLKEpFN+fKvL+MOikDG/mz1JIaUENiAnMd82SZJ7SvDX05y+loHDU+Hi/FKCS6jFDSAnstAyAUQR4LIN7KDPeE//SM3t6eBvBESNUNq0UunBB4mKLAF9dBKPaj1V1cCwcwW11oVsc4IUKgdCoZs3YF2IKpDeBUI8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBEXCSIf+PTXF3Jmbs0xUj4Xtu0nvei3kKdqszcmHrE=;
 b=KT3dTwYF9a0jtzakPaY9kqjSXnFkFM1i62Tc3Cz8kbcJRbtTeKfx68pruInkOtckkEbChX9NSUnNfJPSDFzDY4FA9O0hNduFt+XsLIHMSS8MDMX0++4/c1O1WjWLdP6THYikVBoaNHpc1iTpVn/+3GenKD7cf0a4qvGWOxKPLbQeXuT3pUQrhME4k5Y97c9CHg27psOtZvV48/VL4kI8B29h/jypBXaZamhEgOnaf6/AeNKCXyJ1VWZn5s9pHcz8rk9164P7nPLyVeegj4/cyA6WxxNEXe4A+Y2lsC1/NXP2odfL2oQoRaBaR7B/FVlFOv8t9e+z9y2snDn9Ak2NyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBEXCSIf+PTXF3Jmbs0xUj4Xtu0nvei3kKdqszcmHrE=;
 b=nQnF2txDZPyVm5Qq5kF6U+pap70075p50zTcVXpk8vOXKjjSx9Zh8wEYLEt4k6F4lTKfZMWJl86MRo3nXbDQs2bsUBkd4t38i8yT8uxJpU44AgF4miuz8WXcpo8bZqxydBCbVSXV8zhrxBveoqy1SviHX8jA/Noy690T0aHSBeQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB7033.namprd10.prod.outlook.com (2603:10b6:510:276::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Tue, 21 Nov
 2023 11:30:56 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 11:30:55 +0000
Message-ID: <47e8fd80-3f87-4b87-a875-035e69961392@oracle.com>
Date:   Tue, 21 Nov 2023 11:30:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: scsi regression that after months is still not addressed and now
 bothering 6.1.y users, too
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sagar Biradar <sagar.biradar@microchip.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Hannes Reinecke <hare@suse.de>,
        scsi <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gilbert Wu <gilbert.wu@microchip.com>
References: <c6ff53dc-a001-48ee-8559-b69be8e4db81@leemhuis.info>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <c6ff53dc-a001-48ee-8559-b69be8e4db81@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0021.eurprd04.prod.outlook.com
 (2603:10a6:208:122::34) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: 62587270-bca2-434e-fde4-08dbea855395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWdZbMc/L0rtDw5eivREpABl5YQVi3LBYN/zmrk/gdEk7YFGjAPb0mdpgXVyZn/Xi9R4USe9pwQQztsrnpwcNQRz65ACHfxoKLe8KQlPd4zxHCgHmuFJ5B1NmpBNcbZhIIpN8NPFHzQDQmTjRVYv/A6GTtwCPiiH6FDQ6XKxhHRc4T0ZhPPgl0dUFzOB17b+SRPRhDOCvCr/mbnQ4wE1TrVoUPPMnnbzQYFhkj1MvmqGiW/j5wPxxyLpr34DjhrhyepvvEmYXjvuC7bsct6NLt8KLZGUbNOGOsDrvr5wPGWmLVmRTFQpaGcyyg1Tj84pE7TKSeY0ZE2GvkdAbOoQRGi59aSyb+RC8JYLudc+yiPsgz1/O5fffJX35eGHijDzyjafhwFcVzAfKdDkaXJFSo4f1bs+vAt+9TtKTd2mz4QQOyjYYimyWDQv/gA7qVCQKbQlI5EeebtLem5hIVcOr87p23awDIjwZyqcojaCs5Q6oQz1vnzlCFbm1ooxK/So7LAcJKDTbWPagMTmyewo7TFPgaoqkmHZE7CDKVbKncM0BMW3uO9UjmWE4qT0VQkTli1jTSyUTfhkD8GbsmwEwS9VZBde7qF3XMX0yUKxAFdpfDUGbTc/gQRiACB/M0PmdT/wYFZj0g9tnkSMhGPHosEo1KZO5BhBQaYfPAY0Ctg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6486002)(966005)(478600001)(26005)(53546011)(2616005)(31686004)(6512007)(6506007)(36916002)(83380400001)(6666004)(38100700002)(54906003)(66556008)(66946007)(66476007)(316002)(110136005)(5660300002)(86362001)(31696002)(4744005)(2906002)(7416002)(41300700001)(8676002)(8936002)(4326008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0t3ald4ZTNMQjNCSjYzd2xINFoxTm11MGJWdi9OWVRZU3d0ZGJYZVdTcGVn?=
 =?utf-8?B?Q3gzYzZJdm9qcURzT0IwUHIxQmpVZEx5MzJERU5oMGhaWTV0L2xCUmIxK2lR?=
 =?utf-8?B?dUFlV3JsMXo2R2d3Q3Mya2lGYkdpbDhCMjhMTGQwczBwN1M1Zk1qZWtXUUpP?=
 =?utf-8?B?MzFMU2FGUkFINzRvN3EzZHhCZzlwaTgwYTdwRDlVZ0Vxb0ZRS1lDczdrcWNM?=
 =?utf-8?B?TmxmbVVRSG9iSzFQQUcvWFRhNkdvbVJVZ3FjL0hLNHRkakpaVUoxeFpleGJI?=
 =?utf-8?B?d1JGaHhKUmJ6aS8rNzE3Q0Nhc1JvT2hKVlp4QTNLL1lCNEhoM0NUUHlIQjNT?=
 =?utf-8?B?cThSOVpKcmtuWnhqQU5oOGd6K1YwQ3c3cjAyLzBsSXBpTkZDTEpPb2NLMWVE?=
 =?utf-8?B?OFdRMVIyU1UzVWR6VUhiV284c1hKZE5EYkVYWTVDaDJHNGpLT1Y0THJQeldI?=
 =?utf-8?B?RkVkZVEyeGpxQzhDcmpaOFRmSHhLNjFORzRnS3hsbGhMOHZ0czZCU1ZpTjN0?=
 =?utf-8?B?Qi9NM29rT2NhNGtlVU1mQ3NVd3JxZGJGa0wrekZXNytMMXlab2U3VmpBMmJW?=
 =?utf-8?B?VUxBZFN3MFZSRXhSOXZpZGVvUUx5NzFOa2VLQ3FXS0dIN1dqYW5BeWlBNStz?=
 =?utf-8?B?THd1ZHhyRDhwMWFGWGJaeWlwUnd1WDJ3TzBmYXd1dk5xdyt0OGdFWnllZi9x?=
 =?utf-8?B?Q1h1NUVyT1dBdmF1MnliUGpNMlpJTThyU1R2bjQ5VnJtRGZwRGxscm1uSFBm?=
 =?utf-8?B?MnR2N09BK29iS1ZiMCtpOWN2aHpISFo2aDlPSlJWR1NOSzhLbWJQL3hwY3JC?=
 =?utf-8?B?U3kwbUFTU2g1a2I0a0hxeWcyQm1SS1Rqa2M0eGpQTmtYaUlxamtFcXBnNGVK?=
 =?utf-8?B?ejRlWDdSRjBvU0tpYnNybVJoaysyTzNEMkdjanUxSGFISjNIdDNHNFV4V1B0?=
 =?utf-8?B?SVNTZjdyYjlReWpRcDRNYnlrWmtkdkc4Tkpaei9QSmQwbzh2RTg5ZTJvdlR6?=
 =?utf-8?B?eGtSWkdtdFY5VG9vV2xhdllRYUpXTXhwS081TFBCemVuVUdVdDUySTY0OFlj?=
 =?utf-8?B?SWxsaDdTVC8zakppNVQyMFNDcFlQUktzcGEvUGRNYVpBeVEvZ01sRkIvV0g4?=
 =?utf-8?B?M0ZndXhZUC8xT2ZpVVcyNWFWSkZZY05iRGF3WDFmZ1Rsa3RsZ3pvY0V0ZUtp?=
 =?utf-8?B?OVYzQ2UrRUNnZittckh3Ui9pNWR1TzlWRDYwMWpySXp1NHFqQ0h5OEZsZjZo?=
 =?utf-8?B?TE5OYVd1aDNCVFQzVU15SVhpcm9jRnZCb3dUTDE3WmhLK2Fxc1g1Rzdmekwv?=
 =?utf-8?B?ZmZycTdqeEtZQmgwNE1FWGFEV0pQeC8wT25jSk1EbzAya0FJVzFuRWozeXNN?=
 =?utf-8?B?eUlEU2lOR0RXdDMxZzlCdWV6MmhPSVNhaktTNlNZZGtOakNUL3JLdE5vMUxh?=
 =?utf-8?B?clZkKzFuWlV3alk4VDBwYjI2ZTJYV2FVYXlBdjY2bHNTdTNadXVKM01iMEwr?=
 =?utf-8?B?RHlTREhpREduYUQ5bW42Tm1Qa0w1SWd3Q1R0dzVPNHNSVnNycmtBNnJnMVVJ?=
 =?utf-8?B?T3puU3FKZzRiNW9Md3ZYdkk1THZYUy9BcDk1YzU0K3J5eUc0KzV0d1hLK0FM?=
 =?utf-8?B?c2xSdHd1OVQ3K2toaGxYU09Kdm5NOFh5S1RUSFF3MWZGV056MXl4UkV4cWFk?=
 =?utf-8?B?eHkyejZUaTRYQ0ViQkxiOHQ3ZG0weFh4MGxndURIVEkrV3QxSHZITjdtRFcx?=
 =?utf-8?B?U3VLb1BXdllLc3Y0Tm5LQ1lyR21yWVJzMXM5R3JzSnRwemd0SVdaY3ZXOGk2?=
 =?utf-8?B?NFVoakVmM0FTaUVIWGNwLzVjdDFGUWJxaEZEY3pESGZ6VXZFcVVmVnFYdVMw?=
 =?utf-8?B?VDlwbTkyekU5MnUxcGllQkpETjZkMHUyWmVSV0h4ZzF3dXJsWmJqYjBZcE9i?=
 =?utf-8?B?eWRBbFEzR1VQV0dlMEs1SXVWMmJNOVZuS1VCMXVpUzFKZnI4Q05hM0RYdVhv?=
 =?utf-8?B?YXhVQ2crU1RiOG5kejU1STlGemV6d0kxcjRjY3puaGF0aEVBMXpTSmFXcnBZ?=
 =?utf-8?B?Z2hYbDVrVzJrOERsSE5EVm9nQkFnUHY5S0hRNHJNVlRuWjVLRzk3WUlVYkJx?=
 =?utf-8?Q?qG4wTA7wnqxsmOiPiuV3sFc3F?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YmNna1h3STZHZEhtWXhiSEUwTlZEaG52OEoxZnRkMEIzeWJWU1Y5bEpPWkY5?=
 =?utf-8?B?T1FtZDJJeStxNVhrWnFPaGFCNkdLSUFXeGRLb25PekdLYldnUWwvdDlSdTRh?=
 =?utf-8?B?SmRodWlWbGY5MG5YUDNoQ3pQczJEYjVHRlVFOFZaVVBhSnNZQ0pxcjgwc3Ns?=
 =?utf-8?B?UHhyWG1kYXg3QXVQMForTmFPci9SdHo2WmZqeGRaLzZCd3IxRWhjUXpDVzBh?=
 =?utf-8?B?bEl1RnZ2RkFJWExBU2lUNWgzWlVpdEkyc0p1QW1jNlhTU0JKWjJSRXRUdUxD?=
 =?utf-8?B?TmF3WjdKR1NvcUJqM1RGTTUwTUJ1Q3U2SmVlQlZMUS9qSnpLQmRVZGlOTzlL?=
 =?utf-8?B?NGNERjZxNVdsS0MyaHA4MVlIRmpIeUV0RGxDdzhMNWVTOGQ4LzBzbnQ2YVA1?=
 =?utf-8?B?Nmh5c0g0T2ZDa3h1NFdDczZFK1N1cEd4L2dERWd5Z3BFU2lXdUdFMzc4ZU5z?=
 =?utf-8?B?NCtZd3BBTllIVkZDSHBCMHlKODA1Lzk1OEM0QUpHcDVWUzkrcjZXOERCd3lS?=
 =?utf-8?B?T29PZy9VR1RRQy9ScUVqOE8zdDVNZWRVcU9GWFBiRTNqRzI5S3l1d2FObnRh?=
 =?utf-8?B?UnIzNFVmbW8zdUZtZ0JUUC9WUGVTTGtSUEFWRkpYRDhlV01zZkxnbEovVyt1?=
 =?utf-8?B?ZTdrejNCb3RROCtUNTNUbEdZWGZKZFdHUGp2bWN3Vk1icEVsSEJmT2h5U0ti?=
 =?utf-8?B?VmZHSnNVc3ZpY1RmbGdZVEdHWDVNVDFXZERFZVlJdVkyOG8vVDFqNDJTT1RV?=
 =?utf-8?B?QjdKWGNaWjRkN1JuaUczMXRtZERUaE56Q29ScnJmV3hrZHdtcXJ0SWxkbVJo?=
 =?utf-8?B?cDRXakdMV2RTVDFDZ1lRQ0hKcUM3ZFZZQjd3ZEZZT3NUL1RWZUtFeGtDdTJx?=
 =?utf-8?B?M0FhUmZKNitnVlJHMk9lS0VRNklSRlQyc3lpMkhsbnY0U21pWFFCVjE1dWVz?=
 =?utf-8?B?Und5a1dONmZnOHBnZk5jWER4Zk1CTDFMNmE4cUp1bDdFMWEveGdtRlppR2cz?=
 =?utf-8?B?Z0o5UjFaV094Ylpmblh1Y01BcGpmTUlMcURFYkZFL3hPSll4ZlZ6UENXcGpz?=
 =?utf-8?B?bUFEZ24yT2FXSVFCeHhFM1c1bkNvaDdGMWtOT0hmWTBQZmthcDZCYjZTWkZQ?=
 =?utf-8?B?T2pFeXJsWU5HcUxQUlpaMlhlUGFibG1LS2g5QzdrOS9KRDNQa0xQNE4wdG9T?=
 =?utf-8?B?bFhTSUhlWWN3NFdFQjRuS2xUZjN0N3J1aDZVd3BYM25XaHZ6QWNCVlIwMFV3?=
 =?utf-8?B?UXRrclhPUWQ1eTVZMmgrU2hvSHVQTU9FSG93RmN2Vm9LVzlBQUpOck5peHZw?=
 =?utf-8?B?QjJyY1FjV3pobzE3UlVIbVFqbm15V28vcHNjVGRUcHAzdzQySWhSa2dDRnhh?=
 =?utf-8?B?Um5nbUJaNUkrVDdnOFZpMndEM0I3NXUvUWxGZmMzWkx6ZGJLcmNKcUxLRUpi?=
 =?utf-8?B?TGlvNTJTbnQrVzkyVjVWZGRseUt6MzdVSnJXSVZ3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62587270-bca2-434e-fde4-08dbea855395
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 11:30:55.9225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8PQWIG3LngGK8QgXxPojhTrSaXd2sA2Rmv+dSXj8Emz4A03QDHdeWt4XVA0A0f5JAUpKTVFMblxNqrTSDkjQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7033
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_04,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210089
X-Proofpoint-ORIG-GUID: lK0W2RvZ41XI8Xe4herB55PVeey7uJFB
X-Proofpoint-GUID: lK0W2RvZ41XI8Xe4herB55PVeey7uJFB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2023 09:50, Thorsten Leemhuis wrote:
> Quite a few machines with Adaptec controllers seems to hang for a few
> tens of seconds to a few minutes before things start to work normally
> again for a while:
> https://urldefense.com/v3/__https://bugzilla.kernel.org/show_bug.cgi?id=217599__;!!ACWV5N9M2RV99hQ!L26RD0hu99l3f709EFnXU_V7OaB1jG4Hi7BjKvxRuhDWKFmjrgfksLuXA6eBrBCRtOT8JcRRUvzRsHbyEm41r7tL_pbDfw$  
> 
> That problem is apparently caused by 9dc704dcc09eae ("scsi: aacraid:
> Reply queue mapping to CPUs based on IRQ affinity") [v6.4-rc7]. That
> commit despite a warning of mine to Sasha recently made it into 6.1.53
> -- and that way apparently recently reached more users recently, as
> quite a few joined that ticket.

Is there a full kernel log for this hanging system?

I can only see snippets in the ticket.

And what does /sys/class/scsi_host/host*/nr_hw_queues show?

Thanks,
John


