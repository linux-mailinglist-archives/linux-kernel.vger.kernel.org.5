Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFA67F29F3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjKUKRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjKUKRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:17:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAA2A2;
        Tue, 21 Nov 2023 02:17:05 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALA4307019420;
        Tue, 21 Nov 2023 10:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=vv6UMXLoO2LmmBymxnQDAVOLLJtyT5GVZvKGyAT6UrE=;
 b=3DWiuBhQrAlVuBK1y2U17aWgtEVua280mR+zuFWtLrHWkwhVgvCFKpuhly1OEJDFmpuX
 YAZssfc4xZztlsHoXKnvs1Q61/DRXuexjF1QGUw3tWLVWjL1DgHdOWQhQOQzPfxT64UX
 2I4N9S1Dbn8CjXXYXgYjRoVXUnamgPp3MO/0ocTLHfUg26fPkO1HL2x+Vw2rAHOnF+ay
 YDTjOjnIQwuUZoe3YBCJfA7OBXaWCRFKHdafL9QJdnejz0nii8uzsVVMZRWwmgiuhjOt
 DOVkRNarn0vpfehLrn1TvcSRA3ANZPptcJK8LwJAODMjyivmEOaGzaRVe3D5VnTOpnai fA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uekpempqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 10:16:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL9JvmJ002433;
        Tue, 21 Nov 2023 10:16:26 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq6ra0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 10:16:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Omom5uLekJhXqyab8OEUTyUvRhtOqKrKQ12mmmzlJwbEUz4slXip9FqYkcz+Y/twOGYV1sWcHEkh9F7wM/v9b7vMXIxv/lS8n0/aV5dpVkqLsd+KVa8XKT9WG29OM2PhUzZyxRDyNWtCQ7OLOo5SZ8TxXwIOL+glVfxymzc/kEW3AYxOYQqg31D3MQhLFgsxNZfh3q/Jn5ZzECL/Bd2VgKSGjjGNVAwaaePWOxl63CDQyRAqdIKhl1cd5lWDD2UY7HZHPsWsUC76xwq4JvxRM8pHiUroRIWY7gKOmx9YEaGudP4rMk3RtxXKEzKbHGwLvJS8EmXgj3yMqobmz56exQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vv6UMXLoO2LmmBymxnQDAVOLLJtyT5GVZvKGyAT6UrE=;
 b=gb2S0x4Vrvq7o7+YbRYyw8d0rda/Zwu62JW/kEDq5GN5rnKH9nx2d6gpp/CRiX19whlgkgZk4Mb87kcX0/DNQXJgJP3LYR9DGQdSNW90LSH6jepB8A9tjF/Md62lvE5EH5Zx9BVk6fBmbANXtRZiiDowRCP97jdjn2GD0Vt/suPNWMdT/JaFdK6nmWKybd186yAVPXWLx1b6vU829KHfVPI6hjzJvYzKzxUQKwZeXKKNk/ONWAtj6WVtgK3YuJ5/Bfgh94EfpCSMdJpPMUGz/imd9+9R1qE88VBzRKYx5I8AeL6SEEkZYOyOj7TKn+F6elojvG/msfkgBWXtt2NeUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vv6UMXLoO2LmmBymxnQDAVOLLJtyT5GVZvKGyAT6UrE=;
 b=yqfCq2/4itKDPUEWskdN8I2QJMGSAhHocGa2MBChGfnbGOKUfv25hXJfr8g8jo/0peCgwjk8ZdEyE913uOqqQXkO/jW4i8dRzSs9NF4Z6mQH+2uXPVj50xlDrwv1s8CQXYVGZZKCf1hzQS9rTga+NRR+IXCcEFqisPDEKIubmkQ=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CY5PR10MB6096.namprd10.prod.outlook.com (2603:10b6:930:37::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 10:16:24 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::cef0:d8a0:3eb1:66b2]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::cef0:d8a0:3eb1:66b2%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 10:16:24 +0000
Message-ID: <bbf74f50-c026-4f72-8437-8d15821c0340@oracle.com>
Date:   Tue, 21 Nov 2023 11:16:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: xfs: consolidate XFS docs into its own
 subdirectory
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux XFS <linux-xfs@vger.kernel.org>,
        Linux Kernel Workflows <workflows@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Charles Han <hanchunchao@inspur.com>
References: <20231121095658.28254-1-bagasdotme@gmail.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <20231121095658.28254-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1PR01CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::34) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|CY5PR10MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: fc545f34-e7b0-4d78-2515-08dbea7aea63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kG2xnr16nl7SbIIP3WsdpgWCcMxb2pL8zQYk9YRz6eMO2W39vfbaDonPbKtuJVSms55drS3p7OTrUvj9f89EEgLpnnAsA9ci1D8JzE42dv5Lb3vuJEX9soHl7/E4AsrCmdcg4Qo7MgZl/GcSs3pH5+nYaqclMacxSfzbRuRwvPPfAp32qI7np8NyCC90TpQ91SqwVNGjjXgHRGCDnDte+ctmGe5KOsNxQ7S1CbRsGpnDTMljz9RX0t69XxDARe6FD80Rx/SSQw3h4eZCU18f4eh1T/As4/0qMWaCe6yJq6gcc/fQSUHhc2kpl5MeYXXksE1+UOJhDtcQubCEFiu4EpDZH6Nnl0WgMygBVfcZWUzeGsprfCoCy855s5Oao2WfwC++3fHsaX+UV2QPJI7igkrZQOVAJ7/pMnhApY3nHLt4pUzn4v9KofH5/TyVmlPlVPlNdDXM79VjlTUQW41iCbucQ40Ys6wP331SXxeOdLrt3kWyWN1HIRWFymX0AAGsK6LW9aI5ovtjQfVjWiFP2aveUSzsPbn9Ory0M/3e2CeTvd+UadLPMr4/Yz708miy7DmM9Qubbo55nvVukinYyRixMdCkcdeXqa9OgbtNk68AQX1tKM93UigY62WZVL4wvINI/TqEujvMacypwVEYzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(86362001)(31696002)(31686004)(110136005)(6486002)(6666004)(6506007)(66556008)(66476007)(66946007)(316002)(54906003)(36756003)(53546011)(26005)(6512007)(2616005)(83380400001)(7416002)(2906002)(44832011)(41300700001)(5660300002)(478600001)(38100700002)(4326008)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d20wYVhqdTBsaE01K0c5ZU5Cb2hFUzk1cXVRRUJRWUMvbVlWaGdPNGM2eVJC?=
 =?utf-8?B?UURleHB1REw4U3I4UjZWdXBpZmFEczliZzF6Tzk4alRENzdvdEs4NHhRblZP?=
 =?utf-8?B?SUNYOGlNRzN1WjdyWXMwRXRKd0t4RG9aY0NjdlhYWmVUTGJpVDUyWkwweDRF?=
 =?utf-8?B?Yjlhb3Q5dG1ReVhGd0MxVmlPa3IyajlybElYOHR4RzFLMlJGVW01bVE0NkVs?=
 =?utf-8?B?US9GUHN6WWxDZWZuK00wM2R6VDdNV1dweTJPcWFoTXk4aTNxWUhPT1l4SVpI?=
 =?utf-8?B?aUhOVzR3emhLUnNTUzdla0RZR0MvMjA0NEVTSy9MSEpkTnhOYnN1a0FPRXNo?=
 =?utf-8?B?djA0aTUzNEI4aE9ta3FBdzN0dkZmb0hZQ2pSSEk1U1FDU0l2S2UyUWZUSktr?=
 =?utf-8?B?aG9LRjFHSSsveVNzTlhOQjA1U3pKbUZ3S0p1U0s3SzJqNWt0UmN6SXpNMExl?=
 =?utf-8?B?WnRvaGZYdzlDQXlUYXkxY3YrSDA2SmljUjZzNE9sRGx0V0g4MU5mLzZRdCtr?=
 =?utf-8?B?ZlNZVE9GeUV2Z3lDdWZoSnVPVVhDSHllMGdsMlM5WmZkdlNISUZBUGl0VGVM?=
 =?utf-8?B?QVRNMUlBTEk1cmREbDRoY3NnMnBiQXVOc1pFdTdDZlNWVjVkaXJ0TzJTa2hm?=
 =?utf-8?B?bEhjWnh3U3J6d3hueWdHQ2lUK05DVFdPUkx2RHlLMkV6SW0yalF4VTI5aUVQ?=
 =?utf-8?B?clF6SlRCdC9CcUxOUW9qam1UcXU4dFVadjZUaDIyTFlaM25ncGJWQklSM2o0?=
 =?utf-8?B?QzB6Yit3YXAwK0JNSjJGd0FpVk01WExtOXdxM2ZnSTZhTVU1STlIYlBiOWZr?=
 =?utf-8?B?cnd3bG53bkVqTEZDUFhUZllPVWpQdXF3WFhPcEEwSHZXbXh3d25RdCs3bWxB?=
 =?utf-8?B?WjlObGxvVzYxQ2tRUW9WbE1sU3lnVENFSzVmejdMbmg1NENKMWMvQmExRlVh?=
 =?utf-8?B?dmZQeXhuaE5sMUtmNGVMVGphMmk0c1ZJdFpEd2JDZHd2YkdpMjBXMksxRDNQ?=
 =?utf-8?B?VDVpckg5Z3BDVitxM3JLTjhXUGJwSUU5WDBYZ3p1TE44a2MyeVB2cTBiSiti?=
 =?utf-8?B?SklhTmQ2SmdhWHM1UkN0ZlZaU2UwQW01V1ZHSlEwd29VNVg4T0RneXVtV0c0?=
 =?utf-8?B?VnJPVWdYcXVuZ3NiRHk0WnJqc28wNmI2L1BKKy9NNEVqbXJ4L05Bbndhc3lV?=
 =?utf-8?B?K2x5TXN3Zmk5M2xjd25WRFhRTUVad2JlNk9aZWFWelJpYmFTb1hTVW9OVWZt?=
 =?utf-8?B?cGdJV3lPdGdUZmx0anRvTzJWZG42cmZrTjRETk5GeHVGd2JrMCt3aVg3QmNS?=
 =?utf-8?B?SVZWUTZYaTYvdFozTWF5MXE3SzVBNmkyZFBYZENWTTJ1cDY3Slk1VCt1Yko1?=
 =?utf-8?B?cXNxdFhaTXRzazl6QlN6OGVHR2U3Y1BMWEtWSHBhWGJIVFJFbE5wM1RhanVY?=
 =?utf-8?B?dHF4L2FLUE1yWnpJT0hRb0ZpR3lrckEybS9nUm9FQmRxcDFZbDVFS0FuanBO?=
 =?utf-8?B?OE83YWV3Vm96aWJyR2Y0N2M1a1FLbVV2bFk5Zk40S0R4a0VmUkNiVDFEUG8y?=
 =?utf-8?B?ZGVTTXVMOXBTVEphUGFDZC8xY0VZV1RsT1pPRVNjbDczQU85WjRjREo1bER0?=
 =?utf-8?B?aGQ2QVoyN214bzBHazdBLzlOdnd2a2M3czVvMWluVzZqZnRvNDh0eFd5c3p4?=
 =?utf-8?B?ZkExZFpzY2NoSlhXMUF5VWhKY0hJMU1iSUZsVC83Nk1PK1BPYys3SnRMVFNG?=
 =?utf-8?B?TEgzSDEyMkNhc2RJOTNXdlpvMFN2TFBjbVQxQUtuVkp3NktEM2hBRkMvWFdB?=
 =?utf-8?B?SE1CQ2M4VTdybnhNLzFUdnB5c3NDY3NHcC9ITG50VTJrZ2ZuM0tqVUd0eUVw?=
 =?utf-8?B?Wmk5d2MzYVczMkc0THY3WDVxTTVoRWJHRmZOLzhHTGJtdmVzbVpEMGNUWmU2?=
 =?utf-8?B?b0p4SzVuMTNhQXFsdE5EWHI1VitOemFkemI4STk0ODdrQ2FneWc5eVBqS0w2?=
 =?utf-8?B?U3dVaTJrMG5EZDZtYm54V0RiQWhJR0svbUZndWw1aXJ5VUZGZllGNHlQTEhr?=
 =?utf-8?B?ZUFLK25OMkZmM3FLVFJiOGhLMWpXV3EwUVBweXVXTzdZdnlzMlpSYWMrN3Jj?=
 =?utf-8?B?Z293QkVrUnpicklOaW5NbnlYdW01L3RUMnM4OGMzcEhDSDd0MEg3NGJJdlRZ?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QmhkbTF2ZzM5T29ZdnQwOE41MHhGRThRTG9VUHZTODdlWjBxRkxIbVBsb3Qy?=
 =?utf-8?B?ZFh3TkIwRSt1TStpT3VrMiszMmkxbHhUYWNaWHljamFoR1l3ZFhyNWhGVzJB?=
 =?utf-8?B?QXFRZ2Jka2x0eis4ZlRjNE1LcnErdHhvM242SzA4TUZMYWg0blhTL0p5QkFj?=
 =?utf-8?B?dVU0dDY2K0k3T1dKTUhVRitCcnBCaEdoNUl2YUtGM2JUSjMwQTVSZno2UnBP?=
 =?utf-8?B?MmE1Mm9oQ0Jpby8xV1NCTm5id2VUTHFDUzRQUzJYbEZYWUFYQWZlWGwxN29u?=
 =?utf-8?B?T21DZUpJemwzVGRVb2cxMlh6VXdIRjNtajdGanBmUlJTWjlzK3UzVVRzNzUx?=
 =?utf-8?B?U3dyNy82WVFkdUJvTExGVDliK2dycTZ6RGZnSEJwc3RvWk5UaUdqaWVjZnR6?=
 =?utf-8?B?Rll1VGR6R3FPOE9ldFI5M2l6M3RoWEJlRzA4NkJ4SUJKUkl6WEY4N1RhSUpF?=
 =?utf-8?B?YUw2cU4wandVb1V5V0FwRUp4SDdUeGliQXo5ZWdlSEpBQVlueEc1azRQY1BR?=
 =?utf-8?B?RFhKQVpEWTZoU3BKaVh4aXJ4R2dWZ2x6NDI3QXdkZUZJOXV6ZGJLTU9tR3lG?=
 =?utf-8?B?RUt4ZFU5aDhwNWhqWGc1RDQramRWK0F5ZWU1SmdzSTcrSEtmSVQxcE5iYkFF?=
 =?utf-8?B?NWprbHhSa3U2WHZ1aWdtZE92MFRXSmFFWkxIUkE3a255ekNzV2JFL2o4OS93?=
 =?utf-8?B?N1hxSjArN2RNYUoyUzVyYjU4Q2U1ZWZmT1ptZloyVVg1NXJjRCtrb1hNOVNG?=
 =?utf-8?B?MWkvMnZhbGtjdE83TGQydTdXTWd1UzlseHh6VUdCUXZPdndLWFFHaHQvYWhx?=
 =?utf-8?B?YytpdVdjVTVrYVBCUUFpaW5lM29LM0RaUS8vTWZpbDFLenk0L3JHRzBwbUts?=
 =?utf-8?B?OWROZ0dHZ2lCbUlhN04zZlphT3UyWGg2Nk5LdHBEempPaWlGbHN5dE9EYjE4?=
 =?utf-8?B?cktpQ2oyYU5SeXY4bUFTbG00SExzZlcyT1Z4d0VwWDZ4Q2JHUUxxWEhQRjVW?=
 =?utf-8?B?NjZPNlBpUGd2L1REVytXanpoRmR5VnVIN25HV3FxS1NpTWdjSVNWSnp4Zk04?=
 =?utf-8?B?RTl2QnhING5hejE5Q1pyRXVQVytoKzdENHpneUdpQmFmSWdOQXh2K0ZmOThl?=
 =?utf-8?B?eFdTYWtlYUx5QVJIM2paS2k0eTdaS01Cc21Ya3YwTEVoMTUvblNZTlpMOXNk?=
 =?utf-8?B?Y3NzWEF6L3BhNWk3bVFZUm5IR0JtYVo2QldzUklhRU92dC9YK1NxMEd4eVhF?=
 =?utf-8?B?ZDVEQ2gxTWRPU2hrN0c5RGphN2hSRnVaVTRsL3JmMzFTcVZPMlQrWnBDcjBr?=
 =?utf-8?Q?05AB4tw/an+WnRnjrEsZvX6sx2kfz/1m0h?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc545f34-e7b0-4d78-2515-08dbea7aea63
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 10:16:24.5669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asBXK8mLMu66cRNb3TCqTIMkszwXyIoL8c/vr8xP5skYvpyeP6o580OcPTF+XojEYmp11att9/78H8wmV5uazRFwGhs8r2nNXi7MhzA5E+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6096
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_03,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=943 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210080
X-Proofpoint-GUID: d68D5s59V9pnxvWicDdvTMubI89jCIKw
X-Proofpoint-ORIG-GUID: d68D5s59V9pnxvWicDdvTMubI89jCIKw
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/11/2023 10:56, Bagas Sanjaya wrote:
> XFS docs are currently in upper-level Documentation/filesystems.
> Although these are currently 4 docs, they are already outstanding as
> a group and can be moved to its own subdirectory.
> 
> Consolidate them into Documentation/filesystems/xfs/.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>   Documentation/filesystems/index.rst                |  5 +----
>   Documentation/filesystems/xfs/index.rst            | 14 ++++++++++++++
>   .../{ => xfs}/xfs-delayed-logging-design.rst       |  0
>   .../{ => xfs}/xfs-maintainer-entry-profile.rst     |  0
>   .../{ => xfs}/xfs-online-fsck-design.rst           |  0
>   .../{ => xfs}/xfs-self-describing-metadata.rst     |  0
>   .../maintainer/maintainer-entry-profile.rst        |  2 +-
>   7 files changed, 16 insertions(+), 5 deletions(-)
>   create mode 100644 Documentation/filesystems/xfs/index.rst
>   rename Documentation/filesystems/{ => xfs}/xfs-delayed-logging-design.rst (100%)
>   rename Documentation/filesystems/{ => xfs}/xfs-maintainer-entry-profile.rst (100%)
>   rename Documentation/filesystems/{ => xfs}/xfs-online-fsck-design.rst (100%)
>   rename Documentation/filesystems/{ => xfs}/xfs-self-describing-metadata.rst (100%)

I think you need to update MAINTAINERS as well.

A project-wide git grep for the document names should have turned it up.


Vegard
