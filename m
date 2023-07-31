Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8615276990A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjGaOJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjGaOJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:09:16 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AAD1BC3;
        Mon, 31 Jul 2023 07:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1690812532;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3gxQF1uIWQurCjzjETFdS7E1U9cjlu27YFyom5JTBIU=;
  b=dYG3pLioHsIB8qezZ8ce5ERT9P+ijT2Uz5KwuTsR9Hze/GEgQC/HI60g
   KezcsSd1veDGvfYamzxecceqvD6eD+zfSx0yebYTMzZu/VN7jxuUjOUJz
   A6/oc86aNpVyn78bte0WLF7kG2e/TtoU/EejEdui5omQbUjCnDxNPG8lE
   E=;
X-IronPort-RemoteIP: 104.47.55.173
X-IronPort-MID: 120626626
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:jPSO2a+EQBe07Tr2mMKwDrUDM36TJUtcMsCJ2f8bNWPcYEJGY0x3m
 GodDWqGP6zcYmL3ctslbYvl808O6sCEyodmTFc5pHw8E34SpcT7XtnIdU2Y0wF+jCHgZBk+s
 5hBMImowOQcFCK0SsKFa+C5xZVE/fjUAOG6UKicYXoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqojUNUTNNwRcawr40Ird7ks21BjOkGlA5AdmOqsS5Aa2e0Q9V/rzG4ngdxMUfaEMdgKKb
 76r5K20+Grf4yAsBruN+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+v9T2M4nQVVWk120c+VZk
 72hg3ASpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn9IBDJyCAWlvVbD09NqbDkl/r
 KRbAj4GKSqGvMmY5734b9hNiuoKeZyD0IM34hmMzBn/JNN/G9XpZfWP4tVVmjAtmspJAPDSI
 dIDbiZiZwjBZBsJPUoLDJU5n6GjgXyXnz9w8QrJ4/ZopTWOilUui9ABM/KMEjCObexTklyVu
 STt+GPhDwtBHNee1SCE4jSngeqncSbTAdhKSufmqKQ06LGV7kAUKl4LdXWlm760gW/iRoJeL
 gtI6iV7+MDe82TuFLERRSaQqWSGtxg0X9tWDv186QeRx66S6AGcbkABTz1MLsA8vdE3XhQqz
 lLPlNTsbRR0rLCLRDSC/7eQhTOqNG4eKmpqTS0LVwwe+PH4vZo+yBnIS75LCqekyN3oEDf/6
 zmPoG41gLB7pcwH2qGl9ErKqymxvZWPRQkwji3TX2S4/kZ5e4uiYaS25lXBq/VNNoCUSh+Gp
 ndss8yf6v0eJYuKmSeOBfgWWrek+56tNDzanE4qBJI69hyz9HO5O4Nd+jdzIAFuKMlsUTrge
 lPSv0VJ6YNeJmCna4dweYu6D8lsxq/lffznX/XZdZxVZ5FraCeN5iZnaUWX2ibml01Eua0+M
 pTdcsuqC3sWGIxt1j2/S+wa1PkgwSVW7WHeR5rTyxWhzKrYZXSQD7wCNTOmcuA+6aqf5gHY9
 dpWPMib4xxaXKv1ZSy/2Z5Dc3gJIGI9CJSwrNZYHsaHIwx7CCQiBuXXzLcJZYNoheJWm/3O8
 3X7XVVXoHLjinnXAQGLbG1/crTpXIY5oX9TFSktPlus33UySYOu570YbJw5Yf8s8+kL5fJ1S
 vgZYcTGGfVRQzLG8DQ1bYHw6odlcXyDnx+VJGysZjQyZYVnQSTJ4tKidQzqnBTiFQKyvMo65
 remhgXSRMNZQxw4VZmNLvWy01m2oH4R3vpoWFfFKcVSf0Oq95V2Lyv2jbk8JMRkxQj/+wZ2H
 j2+WX8wzdQhaadsmDUVrchod7uULtY=
IronPort-HdrOrdr: A9a23:am619a6wS+Kj3R3dVgPXwMbXdLJyesId70hD6qkRc3Bom6mj/P
 xG88516faZslgssRMb+exoSZPgfZq0z/cci+Qs1NyZLWrbUQWTXeRfxLqn7zr8GzDvss5xvJ
 0QF5SW0eeAb2RHsQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AA7DUlWjwKEm68GyokPHDXCDh4DJuQySFj13eKAi?=
 =?us-ascii?q?CDF1CZpqaCnqh2a9Kup87?=
X-Talos-MUID: 9a23:orBlKQiWK0hINnIJzOlpYMMpGMBKoLmOJl431pgNmpWZZS11fGuNg2Hi
X-IronPort-AV: E=Sophos;i="6.01,244,1684814400"; 
   d="scan'208";a="120626626"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jul 2023 10:08:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6zVyh6+suW2bXaeTJf1U9nYK+RMzLrTssrnOdvCf0OWPwx78MQeMC4l5mPn51peK6j2UIyXTa9AmPc/4f6MsN4qyJ8N99wU6geqSkBEJwGxEL2eauhOePdM/BHTy5Sk346UH1QCGzB/noXxWvxddaU/4+aGHUE00r2LOVRggPcCGuOKyr6H3IvUidCic0p3tHPEhJGdy8zHUNS8bt8F3jYEmpi91JHEtFpvTEPjwYZmapGK+8NtT52uZ/4XSUndKAzzjkRVywlxEo5St1+2SRhcy5OuDP3P0RYwPYx5QZOzR4Q1tRGRMakthtvZUZnEQETtaWQxneCOQlDYJpYVLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gxQF1uIWQurCjzjETFdS7E1U9cjlu27YFyom5JTBIU=;
 b=WumOQSPwsz8dx4QLcczYYHbBj9KZNFZXbQvaY8VmL7EkLL92pLkr2GDnfo+Th4XVrqrHlHUJdYrx725fhAvW1N/dlMhxaRxjerihG9jzQ+/GZTre3m5zdJ3iRxSG1pOSie7iZwERJafk9n9j1srcjTEKk4b887nfKZzK7cMfDP6oVKJXMsCGBm6GuIsqCE5gXq2+9RDtZLMHQAUb7NY8okk5oL49jsJAedmiOBqoslvrQwbyWiV2AdQ426o2elwHKSOJa0PPUtQapsWq01MqsLwvaJQCwEJ6S6TDyKv7MBNCPQuMG8cYDqYm8qyUo9IMRQ3u6NJzXsLMWe0oyb+Bvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gxQF1uIWQurCjzjETFdS7E1U9cjlu27YFyom5JTBIU=;
 b=amSukf//6LlgQYJeLGuc1QIIi/DXqVPNztrdqbB8W4JKaQHKM0A4u3NGAGE8nnIN57z/B9mwJPc6SjR6WxeuD/CoKMAoOmVGIT+sk7SwOLzxbbHV6d7jty/tiTXdB8SlDSgnTUFA7/Fbb6nIanlV3biIcCBX5H3xk6TbPczaQZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BN7PR03MB3618.namprd03.prod.outlook.com (2603:10b6:406:c3::27)
 by SA0PR03MB5594.namprd03.prod.outlook.com (2603:10b6:806:b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 14:08:48 +0000
Received: from BN7PR03MB3618.namprd03.prod.outlook.com
 ([fe80::8f94:c73a:ffb7:d5e2]) by BN7PR03MB3618.namprd03.prod.outlook.com
 ([fe80::8f94:c73a:ffb7:d5e2%5]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 14:08:48 +0000
Message-ID: <4dba8007-6a37-7ae1-28d2-972aee0a37b1@citrix.com>
Date:   Mon, 31 Jul 2023 15:08:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [patch v2 21/38] x86/cpu: Provide cpu_init/parse_topology()
Content-Language: en-GB
To:     Arjan van de Ven <arjan@linux.intel.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
References: <20230728105650.565799744@linutronix.de>
 <20230728120930.839913695@linutronix.de>
 <BYAPR21MB16889FD224344B1B28BE22A1D705A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <af4c8d30-7072-6196-a467-bc8c8dbb5a2f@linux.intel.com>
In-Reply-To: <af4c8d30-7072-6196-a467-bc8c8dbb5a2f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO0P123CA0009.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::14) To BN7PR03MB3618.namprd03.prod.outlook.com
 (2603:10b6:406:c3::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB3618:EE_|SA0PR03MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: f7d91e62-ca19-4d7a-fa83-08db91cfa8b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oyn4G8fBQjq1q7VkZB0VJNUxN+WAlD4vBwpKxY6Lq4dzmNKYIv8EZzuF0zDlq7itsjHHwtfnSrg3Z0DnquT2d06F0IfHIU8FkVaVvCo3sqGNpI/pPQ8n5oB4Iu3RauPCkiQDnBFdPkJ1bzBaEaiWfVifbdKExbyey4rRO5vPVRTRhMz6/T2vsB+80lcpKa+8GByVxPOu/pl+r5RaROsPUmD29msFNfqOYZR1si2pzaL4j/aJy9NE807a8oo/rl039U1FnPB/JbZ3WjWknJzQ2iKRIkX595UzyY/DAvYMA0R74uJIlHby3DhhfIAU88bko/6jTc/sZwZtdvib7laYwjWZSwYl5BV17cra3PSevJmUBO8ZCPiWFixrWFCO7eU5HUfTGe5OHeM7av6lo4M+fTemjjyh0QSZ7CuXs/nuKK66ssfKD6gdYruMtx+rvRmwPTCiMxJDUJGpIsYbz086zrrybYXDtSlrYL9PFOGY7zdF0AXsruNJKOcpHNh4pd6sGtDddW3owyl8fFE7+qSdodOqeGxEqDBL8xtC/AF7oyamDeTAoPJ+AIVc36s4FgzDjkkpVf0+z+QYsDvBIQ0VDCCnY0R5Y8neWlsnI0HaKNAiwIZ7OeLoQXtZdu82nnp9RwF7ENBHOR03GVLM8eP6MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB3618.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199021)(2906002)(5660300002)(7416002)(8676002)(8936002)(4744005)(316002)(66476007)(66556008)(41300700001)(4326008)(66946007)(36756003)(2616005)(53546011)(26005)(82960400001)(38100700002)(186003)(110136005)(31696002)(6512007)(6486002)(6506007)(6666004)(31686004)(478600001)(54906003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGhhNTBSd0NRVHJMVWozN0VsYTFtNEVlaXpxbUJQZ3F1ZlM5VVRWZWhqVG9k?=
 =?utf-8?B?aUlyRkU4MTZOMkFQYzhiVkRsOXgydUIvV0Mrc0VYWHpnNUFVb3NZQW9ROTVM?=
 =?utf-8?B?NmphYW1yV2lWOFZ4bmpZNFBnbEhuS2wrMnNoc1RYRDVwWWhDcjFYUE5HMm9o?=
 =?utf-8?B?WXlEczVBTlg4YmhKNlBaNi9XRjZEYm0wWisxQXBuSG1PZHYxRWRNaUVyK3B6?=
 =?utf-8?B?aWFCSG40Q09hb3hRSzEyd0F6c0xlODZ6dXhmR3Njamh5ZHppNmt4K0Z0RkFo?=
 =?utf-8?B?UWxXQlFwdno3NU5YRDJQcU5PWHg2N2lDNVBHWWRJUUpST1BtdU1icFFpaDlt?=
 =?utf-8?B?ZlRxb2tlZHVENnVJdlNHV0s3djhkYzVTVktpNGZlS0tvQXJuYjJKdXlnZmRG?=
 =?utf-8?B?bzZBK08vM0tWaTRKMDBPR2JSTmtYeGZwSk5JN093SlBCWUpzZ0xteERMT1oz?=
 =?utf-8?B?YlZwU2pMWk5UQW5mZkZ5SVZWeHIwQzJGSWt3b3JLSkM1REx5anZaaDlwc0F4?=
 =?utf-8?B?ZS96aVpJdWRFc1NIMjJyWFBFM0tpNVduS3pPZEpzTGRwZFJBVzlXWXZVVEFN?=
 =?utf-8?B?NS9vbEV1TGY0UWZjWGcyeHEzZFAxQ1ZQZW5nbnZBZ0dvWTlic2VJTnFkOWxx?=
 =?utf-8?B?K2JLeU5UT3pEcUk4UERXbE5XL2gvY2lPWG92bWg1RzlYYmNFR2VOL09Hd2pV?=
 =?utf-8?B?YmxhOWFKd1ZOZlRXZFFYbkNleWdVSi9ESlZMSlpTb09ER0xSQnFDMmhBWmdX?=
 =?utf-8?B?cmQvUlcyUnVhNGxwV2tBWGhaeDVRdUM0VVorTzJFbUVvR1pxVjZONDA1NGZh?=
 =?utf-8?B?d3hLSVNRZTlJOG1pbmhydW41ZnZmdGphYThuaFFBWkpqRW9SRXhEMElTVFQw?=
 =?utf-8?B?blNzWkRWVFp5Wms1WDBjaVJyblpkNll2UWlXZTVPT2NrSTZmd0ZjbGlmK3hr?=
 =?utf-8?B?ZFh4UXBRS3FZRTJRQXpUcXFzbG96ZHNEenc0enBYNjNaYXd3elJMUHVNSWZu?=
 =?utf-8?B?YzZwQ0lodHExTlh1dFZhdWhPTnBFb21xNVBIdFNDTG5XTFhuOEhPOVJQZXBS?=
 =?utf-8?B?VFh4SklrRk5IaFQ1Wjc5eit2OVBpZWltdDNPZFp0N1NOa3lHYVhkOWxqYzZ2?=
 =?utf-8?B?MGVQdUdkclFBNHVBSi8yaGdSc0dIcjlMazBUc0liLzRzVGZGT1o5NmhBdmdD?=
 =?utf-8?B?bW9NZzdQdXRvN1F0ZTc0OTR5NjFTNEl6QkMxaWpVZ1VkWHZZTDRDZHExNXRC?=
 =?utf-8?B?YnVUeWZ6V3VwRk0zVkEzdHNFWWZqWnhZK0NKMVlUQW1lSDlrQ2Q1MGcwT3dS?=
 =?utf-8?B?bUJjVXVSNTk5dGJLcEwwNnJ5TjIxVmpXRDA5TGpaa0svYldsQjJwL0Rhb0VV?=
 =?utf-8?B?RnFCZU8xWi9ZL1RiQ1lKWVZaOUNTZlMxMlRFOExqRExOUVVRSnErVUhXallv?=
 =?utf-8?B?OGIzTStYQkhrVVZkOU45cDdlaTZIdjVWdjdlSjR1R2VKeXJVc2Z2WEdBam45?=
 =?utf-8?B?bkpGMmowaytCL3JDSXlyeERydXR2MjVBZnhYcUJma1dxSG1lSVV2YlBrYTIz?=
 =?utf-8?B?dElhSmtHTVNPSTdFaHNEVjd5enZLNHdxb3FBZmNuN1k2clZCYkVlZm9ncEdZ?=
 =?utf-8?B?RTZoVXF6emVLM2daRG1LTEplMGdGRjVRL2N4bGl6czhObDF2c0I2US91VlBt?=
 =?utf-8?B?emZQSXBqYjdwWmVkdDh0MnVuc2ZjVHl4UnNZRVc4S25xWWVpR1NhRXE3VGQx?=
 =?utf-8?B?LzJYRWdDQVljTkZzUWVUT3BlMHhzcHBDRVh6b2gyMy8vbkJPWFk0OEV4NGJu?=
 =?utf-8?B?ckZNMk5kbUc3RkZqV1NTMXJOUEhHSmlVejRNZFJTVkUzeFdOT0U5MTBlakZq?=
 =?utf-8?B?RVVwNkRKZFptMVhGUko5OVlQVXpxQXVVblZhem53V3ZTR1g3MFpZZFdjVEhi?=
 =?utf-8?B?MWluV2JxV1A1dmN3ak9rSmRvZWh2dlU3WUF0TlpvU2krR3ZRZWZkNlVKOTQ2?=
 =?utf-8?B?bHFoUXdsbmh0MG1yc2lFeTR0em5UVHRYSWc1NUUvQWIvRWVlNmNzSloxcE9a?=
 =?utf-8?B?d3lrMDZQU3I3c3ZDY3BDQjk2ZU9oTHRKOThYQWhEY3ppK3ZJWjdrSDNMNHZ0?=
 =?utf-8?B?c2NYNlN6SGVoYlc5Mk5waks3SXFpME5XVm95RHlJMjRGUE9LVWoxWTVqeUJV?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VU11SWR1YXkraWszUFZLS011QTQ2R20rYzdTRW1tWEdsN2lxT0NFV2Z3ZzJN?=
 =?utf-8?B?RUhQZDNRVk44VnFuNk01TUlOOS81a0F0aHRWYStiYjZ5YSt0MG9TQjIwSHN5?=
 =?utf-8?B?cU5KYzlyOHZEdU9YOGJuUXB4dXp2Q2crQUZnbFpVVXVhaDdtank4UTBXYlNS?=
 =?utf-8?B?ZGwyYnFDcUl3VkJuMDRGLytHbG1rbWIycWFJSFh2MVB5WkkrK2E1NWVobVVG?=
 =?utf-8?B?LzBwcW1rQ25uSy9WK0pZa2RZVFJ2b2cwOGlNWnd4UlV5WThLU0ZnRHJjNEZ0?=
 =?utf-8?B?WmlMZkVnYm9jT2JjY3RFWmpOYno4S3A5SDFuOC9JdmFJUWZKSkZNbjl6ZTJW?=
 =?utf-8?B?ZjBYVlFDT0U4ZVlhandnZE1rcHo0eW43SXp0STN2MjZXQnp0YllxYzNRcXp4?=
 =?utf-8?B?OWhSdFE2QkM5Tm80ZnpRRlJaK2JTajlvZ09IWE8zNHFHU0ZSQSsxVWNCTGoz?=
 =?utf-8?B?M29TUHk2MThxeWpudTR2ZWU5RFM5dzkrUGhoeE5aTVIzMjFJRDRuVzdFK0Yw?=
 =?utf-8?B?dlVUUmsrSDBmbTgwSklCRFdGMWtMTWw3eTZsa1IzRU5CV0RZK2tCVEhKS1pS?=
 =?utf-8?B?WUVrdG9Id3hqUkJqbjVwZi93WnBhRXZUSWZad1dGbEtWbzhHZ0RNQ3FDWHV5?=
 =?utf-8?B?WnpkNjF2aklqUUdDdWd3cmNkaGtCa00rTXJVakhXZzhSc3ZsVjFKVXh1TEs5?=
 =?utf-8?B?ZzkxUUtzOW9iT252andPUkRmYVNaNklkRHJPU0N5cFlmcWRpZEJqSi84V1BR?=
 =?utf-8?B?MDRWQXAyUXdLdTlXN2psRDhkMk1kNytXeE9FSGtvcUo0bVE2bXUvZUxwd1Fn?=
 =?utf-8?B?T3puYk9sTGJXTVhjSm9pRjFCOHB3bFhOVHdLUGd2NmRDbnRXczlDMEwzRnJ5?=
 =?utf-8?B?QkZIaEZXczd4M3ZVVjgyUnZINm9OQVdmRUlsQUJiNjFLS0x6MnJTY0RvTFM3?=
 =?utf-8?B?c1lCbGdVVlFSL0VEL1hEM1ZMZ3kxdEVWcXQrUEtnc1pqMmxoUnc2d0pCU2dG?=
 =?utf-8?B?MDJZOFl3ZXFsMXo2em95ZlVLcEtyZno2T2V6L0dzeTFtMDkvNmQxd0swZGhk?=
 =?utf-8?B?aGtyN1dvczIrajhaR1NVYmVTN3kxcTh4c0RsejltTDR3VzM1OFJxNWJtN3Mv?=
 =?utf-8?B?Q0NodzhlZXJTTC9GZDlwbjdSQ0o1UGhORzNQYlh4a3FjWnByL0VOa2VZdUht?=
 =?utf-8?B?NXFXNktnNUxEd0ZCT1pteHZDS0xmUStGMTFadXpQS3VBcnFqS3ErYXlwbHRE?=
 =?utf-8?B?bHpXUnJ6NnJiZ1RlY0Y3TlpkZDRTdlJOTmZkSy9IaHBZMjR0WDQzd1ZGVlB0?=
 =?utf-8?B?bWlZM0krWHR3emwxOXJXVkN4bjVvQjhPV3A2QkxPbzcrVGpJYmRSSmlUOTZr?=
 =?utf-8?B?THVhZkdtcldKSGtCSU4vcjJvQ2Nuc1cySDg1b2RIZzlPcDNKQ051ZG9tSHUw?=
 =?utf-8?B?Rm03eS9zYzV4RTI0ZUZyLysvcGxhSVV5UURRbUVFcmFnRmdwUE1VVGlDNmdw?=
 =?utf-8?Q?mRiCMA=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d91e62-ca19-4d7a-fa83-08db91cfa8b4
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB3618.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 14:08:47.9940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAYbNhhWlEx5rDOX4+8QJDAryg5qyk6u5Am74vOeexgXdbw8Hfwl+Kvje40R0CKq9k2CP/M7bh6dlJ1L9gSHumez9lhHgCnCuIk1pMj0oA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5594
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2023 2:47 pm, Arjan van de Ven wrote:
> On 7/30/2023 9:05 PM, Michael Kelley (LINUX) wrote:
>> Does anyone have suggestions on a different way to handle
>> this that's better than the above diff?  Other thoughts?
>
> how badly do you need xapic ? Meaning, can x2apic just be used instead
> always

x2APIC under virt is a problem if you don't want to fully emulate an
IOMMU just for int-remapping purposes.

You don't know a-priori whether a particular guest kernel knows about
e.g. the rsvd bit trick in IO-APIC RTEs to allow a 32k destination id.

The only generally compatible way is to start in xAPIC mode, leave all
the enumeration hints around which say "really really please switch into
x2APIC mode", and hope the kernel does.

~Andrew
