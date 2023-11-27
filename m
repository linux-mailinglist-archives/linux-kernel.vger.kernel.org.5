Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0527FAC9A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbjK0Vcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjK0Vcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:32:51 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C98D59;
        Mon, 27 Nov 2023 13:32:57 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARKo4vZ029574;
        Mon, 27 Nov 2023 21:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=tpT2AzhppQJSCHnaqaGnpGnCY/GocgGr3oHohGUvph0=;
 b=npuW0CKcVmI+hfc6fkWadNoBBd8wPvjKlYS3tVmEX0c8vsm9/j0rcFi1rjma/Mcic+b3
 BqUM7prI7YGsQoX8AFT7RI8OwrYeCp2EJhcvjN7JjsD45VRFz99kmSQAulB9wYEasUJl
 MMO0nVk6gTGl3suo0l8+EsjeWQ72/82WCL15k3zPGHPTrEFh3yS7hnZm3qc6yvuBVL7F
 ppOWNy+pl+vsZsEjQrqI4Qh/vaLjGHokzwo02HW7Hu7k3LqAQZlx3Jock7hadsZmdKBi
 ruBnnNRq/WBdl9K71Y/ZOzb+UboSQiSrEkNc2PbxlOUckYckmv+goYSa0nZoCwZAwGS/ 8w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk9fum1d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 21:26:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARKMxiW012667;
        Mon, 27 Nov 2023 21:26:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cbp66f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 21:26:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSiL9CGfTaAzpl4uss2fBlcjcnKpkvlsiRbZ6Hfx4Od9BKgBLIb1UD1yEgpMoJ62jQM2HLWsa4aFTTiJA1px6u5Dw/xKCf3UqBzzLH2b5I2Ue18Z17UqEPeU2rbj/wN0UMT/kXGAhdlYpwF07A2XYPXDL8vk25SP64yw4SNnglHZb2OLgRjJXvJQKLu/yR0x8VKDR06P8+89EhpiXO+QiwS4vIudaYMVbCy2YXU260COy+DcmN/aqrNJn55Uc4dm3V8Un9MkZDWnXqbaAg+Z/B9BGFtmQEgQ+Eci4FmdMs7s63haan18gE/SwhsybfpIFMWpPcn6jvk41WkNCgRuYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpT2AzhppQJSCHnaqaGnpGnCY/GocgGr3oHohGUvph0=;
 b=BmyPpMzesBA0Nm2DXEvlOPT3EWLi5wgMtIk+e8vkvRpO1wXpJ4MwD6NL01dEnAfyLOPC1zutO5uLqeEiq+UojgJk4jpdPgRfqlYhy7+tLQv2WATIWaY+3967Y4g/btk76w4Dad4MteQO3pdwziCDfq2A3t7qC/cIg2777P1RDRGfPPBHs6xZQDXPak8sUHlqrnDHMzXMgWWJaw8MDSspDl3jXu9q8xF4w02EQWdZB1k/5U5KoA1paJF8OK2fDUH2IZgjwVie5ifKCd+3qHcyCzgZC9x46IuTryIy/C3Cf84nLiS0UWEfXNutNYYwbfauBBNncVRT+tjHINUnZ+1OYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpT2AzhppQJSCHnaqaGnpGnCY/GocgGr3oHohGUvph0=;
 b=W+iUO8UQyYjqj1tIB/7Jfh1lOS25nJgJyoH0Amqi+YU/f1jwGBF5zSrr/AjJQBeV9PXevO0uY7jH+SoKfIbe8RMmS5c7Ada9uebyMNHhz5IIUQ/VKPl/GG+YVP8bFSgD0o+k+hlqdJ6tdVVGrgGyRJjd18HFtWuZCnH9Bsl7ZTs=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by BLAPR10MB5074.namprd10.prod.outlook.com (2603:10b6:208:30d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 21:26:40 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 21:26:40 +0000
Message-ID: <b760bf11-c8a7-4f9f-b2c5-2e35e84e46d2@oracle.com>
Date:   Mon, 27 Nov 2023 15:26:38 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: be2iscsi: fix a memleak in beiscsi_init_wrb_handle
Content-Language: en-US
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Ketan Mukadam <ketan.mukadam@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Soni Jose <sony.john-n@emulex.com>,
        Jayamohan Kallickal <jayamohank@gmail.com>,
        James Bottomley <JBottomley@Parallels.com>,
        Mike Christie <michaelc@cs.wisc.edu>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231123081941.24854-1-dinghao.liu@zju.edu.cn>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20231123081941.24854-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::16) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|BLAPR10MB5074:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe88fc8-7b63-49b7-def3-08dbef8f8b89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4XvBGS/untgXtpKpSWqArS5YENs3YdQwEMTCOemZkTacm0GUQJkVZGrw5IdU2fYAFSTSVT0LN49J6odCg4icDn0SS+Ld0oy6XefMmNxNvRYp1c5u5Je1mQb2fzoiEyoxF7uARLcfig8P+sxerBJ1WxbdDCFU1saG5wGmrbf/pSZK/OBLwqd6AhUizLYiSxcDiszJpyw0VSwWBjiC5JkOTDn37jGmXTF3XCynVRkxP1W5m68eGSrTCf+x4IwpNzeKBk6Tdm17daevG5FhW/taK5eiUsW1QJXIcasMXLCiN3SaBuIam+B8r95lusegrXaFDscCdoiPYfSloMwWekwQUMdnFUExgr+YRN3dKBoApn6/Ai62kAVUxsRGPAcBAGaxmHlzswDNobqde4/J4LbSKUCz3Ck03yxOtXhwg1uTclbCHj7M34s4bOjBgA4d806JB6I5Yd/oviWcBS8QsYfgbWzqjapXS27ODMbp7zpeWeqzouTElJ44OIVyLK4p2Xq5ipMRuauIbRD+Kyikatlw6K2NZLi43VTGTrwCLFhJGQUws3T84PtAKzq1PBihNMZAPHQtChGGFEHRAdyYRSgivtVNoxVJN33Ry/3BPtJdT9QCwBpkReMizCmO2eX8hdWbpjn50CTuxdH29ks2ioLiKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(136003)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(38100700002)(36756003)(86362001)(31696002)(41300700001)(4326008)(8936002)(8676002)(54906003)(316002)(6916009)(66476007)(66946007)(6512007)(66556008)(53546011)(6506007)(478600001)(6486002)(5660300002)(2906002)(4744005)(31686004)(26005)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QS9iMDJrRlZkZnVwelRHUGs5RjcvRlFzMnRTTWhORHNhT0VTSVB4UDU5SmE4?=
 =?utf-8?B?R0VkMk5yclY5M1pQbVQyclMyWkxGOUREa01PbDZLOFE5MU1rM2ttV244QkU3?=
 =?utf-8?B?eGUzOFJLNnhJN21KMU9JdG80WDN4MjNNMXRCSUVwQnVRdE42VmQzQWNQWndB?=
 =?utf-8?B?aUN3WmR4WnVFU0pIbDk3ZEc4VGdlUVkyUjJkZy9PRncrN3g0a0VHM1MzcU5H?=
 =?utf-8?B?V0t4bnhWcjNNd1lBZzBmM0dCcFUxaXR6UG5VNmhsQnZRRFBiS3JqdC9VY2lv?=
 =?utf-8?B?eVl3aHR2RndkR1B5ejVudXpNT2ZlVi9VWWxERmlKbExqYUtBOEhjTGhJMTl4?=
 =?utf-8?B?bUQzT2szY2JiMk93TkVMY2VPNktoeU9vQ0R5K21MZE5GcDZ2Wi9TaE00SXNH?=
 =?utf-8?B?NTJ4cWZ6ZXJSc0ZUYVRMMjM2ZnZaWEhDUmdQMEVDck5NL2dDVVJGQU96M3VR?=
 =?utf-8?B?d0pvOUgwTGo4Tlc1Rm1EZDFVRFFUWE5meXJYdkdZRG5WWDJTVlFJa05SK01a?=
 =?utf-8?B?VUlYYjJYL2RFenJwVkRXOVRhMVh4TnZyZmplZ2NaN2o3eDAyQkZwUXpaMTFz?=
 =?utf-8?B?N3BuSUlYTXl5TXZVWXdHcm1ZdlQ1WkZsbWtIV0xsV2xoS3VLM0tzM1h6N0Rv?=
 =?utf-8?B?RStvNFJ5Z1RLd1dNKzc3dDhVUEo5ZVFNSXJaUFQ2cm5GZytYYW5lRTVuQjF4?=
 =?utf-8?B?R3VqS3NhbTJKeDlza0NhUFhzMHVrclNkWVRXaWhqdUtieHY0ZjZoU3JaYklS?=
 =?utf-8?B?cWdORGUxNzRHbVpFekxYZENWd0IxTGFGR1V1K21FRzJnZE50VldiZDgvaXlT?=
 =?utf-8?B?RTJmQWxmaVA3ZmdJSUJqekpSY2lsbnpGMSszRjl4OEhvUlhyRUt0bEpYSkF5?=
 =?utf-8?B?WDlueEVHODZUWFpPcFczZDRaQUMrUk9USkNPQTIySG5KWk43SlcxbGFGcDZx?=
 =?utf-8?B?eWFMT0FQM0VpMTZLOEhKUGJsb1JjNm5FUjN3OCtyZHkzOWFnblQveFFaTVRk?=
 =?utf-8?B?ajRQSXFJT0Nua2h2VGtTeEdyR3Nod1ZEUWs1L0pqaU05TS8zd1RIclR3emRL?=
 =?utf-8?B?MHRra0NkenBpTXlDUkR2N1R6a2VEUXkxS3p4UjJ4Q1hIeEd2TXBWZG90WTBH?=
 =?utf-8?B?QlhMUmU5TlhyM2swNThDZWRoWmp1VFFIWmFPOXlSWGNUMUJQM2xKM2N1Qzla?=
 =?utf-8?B?T3VDZ1YvenlETXJ1TWM2WWJUREJTM0psNnNuUTd4WXpWTGVCRS9QVWJmNnYy?=
 =?utf-8?B?bDB2MTg0K3hxN3FFM1hYZVpjV1l2UGZPOWRtWTdXeVV1WitJa2wrU3pzdUVz?=
 =?utf-8?B?eXlhN1FmTHRISjVpMlhOU2VzNGNuMDN3SzZHVFp5NVNSOFUzUHFxWi9GWnZ2?=
 =?utf-8?B?blFYTkNiQ0ZXaUUvZlZZVStIM1RLUW5hWmsxb3E4aEs1WU96b0R5RmtSNHhv?=
 =?utf-8?B?TnpHZDFwUXhlQkFmUGltdzZzQXZyc2Zzb09lOTJSeXU2VjdZSFFYSTA1SG1O?=
 =?utf-8?B?bDNlVG5ndVBIUDhDeUM0R0VPUTFCWWdzUEs3TkZKTm1BR2IzRkFvY1M5WGJ0?=
 =?utf-8?B?aDF1VlcyMHZUTGdaT0l2USs2QUJHSXlPOXJVRjdGeWc5VC9GTkhKQks4L01P?=
 =?utf-8?B?aWxsZVM2Zy9ETXdZbGIrbFRlMUxDcnJPcDNQeEpOSm5scGZwR2pUMFFLNHRC?=
 =?utf-8?B?TmxlRWIxalBLejc4ZkJqam5iQ3dyRlRFVVAwNldXUXV0NnlFb3NtdFR2S0pK?=
 =?utf-8?B?NjZSVlZGZG95cFhaanpTb3RaUkh6UCt0ZDBIRUwyeGZmSDFGV2tDVW9sa21t?=
 =?utf-8?B?cksyb21yRFhudjN3aEFpYUQrd0FOaXVpWmg5R2FTL2JBdlpLbHhwbm90ZjZs?=
 =?utf-8?B?clFOU2FxUEM1NlRSajREM3liYUtWSmg2MUFJUXBBTGxXOUg0MlVZaXoxZGg1?=
 =?utf-8?B?WVdsc1BZYjd3Vk0wV3JNRjNCRzdrMXZXT2RMU1E2cDJQVVdjREFia1NFUGI2?=
 =?utf-8?B?TFF0TE1kbGNLTkM2U2dhN1pTckd3UERXbGpNRzczN2gyT2RESm9YVmp0OUhn?=
 =?utf-8?B?dHU3THJPU3ptcWtnbVpDUllVcWVEem0xZGorMU5oQ21aV0ZEdkZpdEhTNW5O?=
 =?utf-8?B?dnFla0t0R1JJL3lQendlKzJob09jUWxYbUhSbm00K2FteVN2eHh1Vm5GdWti?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NzJSN3VGQ0I1bnQ4VFZDaFJodTFtbnl5WG1xNVkzeHhvcGc0OEhQTjEyNlNk?=
 =?utf-8?B?bHhqaTRVRlBRVVF0SEJqQm9vbVNMZU03aktDdEp4bGtsckxiRW9TdzhTREN6?=
 =?utf-8?B?eG9mRmc4K1NBYnM4RVBhMFE0bXh2V1BZWTFtTHRFbGdzN0NldFdnSHdkc1VZ?=
 =?utf-8?B?TnlGbU5LTzFndkJSUnVDc0RaS0hock44ZkJSSnpFdWpKNFZZZkRlZ2t1Qy9H?=
 =?utf-8?B?Y09BVG02L3RlWW55T3J3WmJycjQwNk5EY2MzU3YxRzFPVFd5b2N5M2NwTHhF?=
 =?utf-8?B?MklCVzlBeSthaTdiTEZ3SGlqVGNLQnNIZ0hXM2FwNGZYdm5OYmIyQlhzV1cv?=
 =?utf-8?B?UVFUS0JHTHNxR3J5M3NXRHh2Vi9tendCREhaamIzcFYvekQydWI2RHVZTUE0?=
 =?utf-8?B?QXIwZnF4ZlhPOWhHOTgrSWQyM2FhUGxKclF6VU9HaS92RmprUFhLeG5DNE5C?=
 =?utf-8?B?MVliQi9nQVIyb1hGQXNSUGtSb2d0aEhpUTIrdlVTc0grc3RjSThwTm8vaVVX?=
 =?utf-8?B?YnpUaFlsRlR4SFBSMlZuSzNZRHZLVFJ6bUtybXdSUHUxajNsTFBRb3lEL2ZH?=
 =?utf-8?B?Rnp2M013czdnZG5aeWJXL0kyNGgySGlpOWxxZGtVOHNuMjFSbjZ5eFU4blVk?=
 =?utf-8?B?bEZWVkgyVFZvb3VwSDN1Y2lhb3FHWXNpOEtNTEZTZDFQbnI4K3hiSUI2Wm1s?=
 =?utf-8?B?N3lsbmc5a0p0RHBDa0w3NDBTNTVqTzJVVlE2VFZndUlhSVJFejRDTTZmdFhx?=
 =?utf-8?B?a1BjaWtFbWNFNFhhZkphTDNqRDVtZFJodFd3T2FCSlhIMFcySkxhVDBURk1L?=
 =?utf-8?B?bUU0NFUzYXMrdWF2UzZQamJ5U25nQUt6Q1kwUzJ0YWJ2UC8rZjdlcjg4Z0hB?=
 =?utf-8?B?RmhEdjZQME9xQVROTmZtMlhMVmFNNk55WlhyNnU2NktuOG5CdHZEMlVHUDR1?=
 =?utf-8?B?Mkltd3piNkhRT0dvZlg4bXlHYzR4TGg0L2psM1N0Sk1seGpFeUtEUzR0NW1J?=
 =?utf-8?B?NnU0azJnRlRFeEMwWXlrbTBwWktaYjZMQlJsQUlIWU1nVE5yUWN4ZEtRbnZ6?=
 =?utf-8?B?MjZDYVcvNE9aaTBOS3FvQWVUamxHWTgvWE9JNWFvcVp1TlpYZXFGTCtEOGxk?=
 =?utf-8?B?U1VhdWtVazdsUjZlMXlyRDluVjIrZThtWDJwMzVtWlo0VTh6V3pRVjlYOXgw?=
 =?utf-8?B?eWwzUXVvM1ZKZWlZVURJakZ2N0tHMFdURkRWMmZpV2Q0OHdUMkw3MmkxVGlx?=
 =?utf-8?B?QXd4ZWNTbFVmRDVrNVJHQ05FV0ZBK08vTG5XMU4rRkEwV1NtdGNueW5XbWlu?=
 =?utf-8?Q?KfoLUjUQePhoU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe88fc8-7b63-49b7-def3-08dbef8f8b89
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 21:26:40.5497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pua/l0VgC8qMnTe9rb5oGjmjmkoLuSxe3jY/i9t74KJNyuq8wHfhfIFAgNpkGCJFbKqXauhqqpNXFs8DywVtBzgoHUOQ1uJ459O+QVe1aig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5074
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_19,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311270149
X-Proofpoint-ORIG-GUID: LyHbRZmStpwrO6zn2TvSzH1gVWrSDRjL
X-Proofpoint-GUID: LyHbRZmStpwrO6zn2TvSzH1gVWrSDRjL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/23 2:19 AM, Dinghao Liu wrote:
> When an error occurs in the for loop of beiscsi_init_wrb_handle(),
> we should free phwi_ctxt->be_wrbq before returning an error code
> to prevent potential memleak.
> 
> Fixes: a7909b396ba7 ("[SCSI] be2iscsi: Fix dynamic CID allocation Mechanism in driver")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/scsi/be2iscsi/be_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
> index e48f14ad6dfd..06acb5ff609e 100644
> --- a/drivers/scsi/be2iscsi/be_main.c
> +++ b/drivers/scsi/be2iscsi/be_main.c
> @@ -2710,6 +2710,7 @@ static int beiscsi_init_wrb_handle(struct beiscsi_hba *phba)
>  		kfree(pwrb_context->pwrb_handle_base);
>  		kfree(pwrb_context->pwrb_handle_basestd);
>  	}
> +	kfree(phwi_ctxt->be_wrbq);
>  	return -ENOMEM;
>  }
>  

Reviewed-by: Mike Christie <michael.christie@oracle.com>
