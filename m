Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7ADC79C15D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjILA5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 20:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjILA5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 20:57:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5190118537;
        Mon, 11 Sep 2023 17:46:06 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BJjYqR028431;
        Mon, 11 Sep 2023 22:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=x+CWHpYE/PfGkdAYIgxMU6em98DtPt+TtrtIwYfwAB4=;
 b=DYbfZNDbSAwqbTV9S++3ym5xZ2wlbvPRR8oGc6j3EFzDPxXjT/64Foa1vo6ivMsOHylf
 9pjQDyEBdQoStX3ysZArHO2fXYoHBuTXj0vu+MGxocHDCJ7ahAmXUL738DnXLHNdOryJ
 VsVmF5UECvAEC5W+xTyggCHDDljAmB8w/EiHWdyxqPtNSpi7ANC0OyaySAuCZZialOYO
 7Bd2qD8mvvoAwjAvjChMr5wFJzsEq7SdvYpWZIuDNtx6CiAdp1A9W1Qx1HY2Az9ABbn6
 U+NdQ7qVYBp3BbpUTwHGlWZCFMMBTTH9j+sYPoKWNY/Ob9UUAP68VDXbZwQo8wpOatUT TQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jp7ak00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 22:17:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38BM92ju002682;
        Mon, 11 Sep 2023 22:17:50 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5b4awu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 22:17:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xz/zFuFJuhIuXYDql0EuHGdqupvH2j/Rwgf/+KGvCw7WRFsmoSMKfJgwta9gropFXF8ocxBma58a2/1MHwj2B/mkybSW5PU7Jind2fRxNYuvIffx3xUZ3AC1O3LUYhLY/ge0RsgGQG+WgT7bI2dph0YBT5jJy4J+7mYGJM0s2X/nmcdUjZIuHES9fnM3zUXJDXNS5c8lSWj4Ajw3SIDA+GaBzUKwCgvHd9VhE4m+KxoIoBnZNf1LVcypqvlm+Fj5hXp5OAiInCIa6gZRrp40Wvtalsn+NMr2m+21hR1KJvmUr2cPvzpHEdM5N0GDmau1ccZGsxZzVrJUeT36H48wYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+CWHpYE/PfGkdAYIgxMU6em98DtPt+TtrtIwYfwAB4=;
 b=E9psgobINtrKV2ECJkkdwkIO6Wr2n3mhiqZnMzP2wK9afzvsToQ1c5HoTRfbXvDuAr1Gs/m2lSQ/8V2XnNo52Zbof6LqaMZUvK/GTMiOdoeVjmDJBeIvD+wzb2DtfQsl1ehNvG5tvse8LSkaLTV7SIYlbGZ7BuW8bC0pzMrkRfJJPXqVhgJSYxuKKHlmWDGcm9DRScd4iwgf9A1cbKX5LgRr0wxOU/YUBpfdF9tYaaqeN+oOhUn7jtTcB1v0efefYlpWOp6n1yQK0F69ke6XMVSW5xqnOXOM0jgSXOC2RDDxbgxqjEKa669/gAUFPRqqTJD1tgcq02ynGq3JJsuUfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+CWHpYE/PfGkdAYIgxMU6em98DtPt+TtrtIwYfwAB4=;
 b=TQivx892k2ocROIeSw33+5bKuFZ5V+N8zNKgonKDKnQJHUWFe70tnRV6Quf+YKI55ir5Rpk4O1ZBehdzw5/j1bu5o0DJp5mv+S1JuMZ7DnkJC248MIGAts0ZbQMnozDbUk/87V2iC2oBmoTxERHZ2f9XgzBseHK5Yjs9CaqkLEM=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SJ0PR10MB6327.namprd10.prod.outlook.com (2603:10b6:a03:44d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 22:17:47 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::3f7b:855:6a95:8aed]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::3f7b:855:6a95:8aed%4]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 22:17:47 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
CC:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "mic@linux.microsoft.com" <mic@linux.microsoft.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH] certs: Restrict blacklist updates to the secondary
 trusted keyring
Thread-Topic: [PATCH] certs: Restrict blacklist updates to the secondary
 trusted keyring
Thread-Index: AQHZ4p0BkG9ylPk27Eafo4TPmLwJdbAVoqeAgAA4j4CAAFsjgA==
Date:   Mon, 11 Sep 2023 22:17:47 +0000
Message-ID: <CEA476C1-4CE5-4FFC-91D7-6061C8605B18@oracle.com>
References: <20230908213428.731513-1-eric.snowberg@oracle.com>
 <097a0413b27ed9792dc598ff184730bcf6ae8fcf.camel@linux.ibm.com>
 <20230911.chaeghaeJ4ei@digikod.net>
In-Reply-To: <20230911.chaeghaeJ4ei@digikod.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|SJ0PR10MB6327:EE_
x-ms-office365-filtering-correlation-id: 484ea054-1614-47bd-14e8-08dbb314edff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P7T61GczyupDIOwtfWpKrCij8KXaumFCdtwCLs8ht4CA8XWOepzdbipU1yb+WuAD1TpgK5Qbq7wfXy1jZrmig4PzHST6eYqiYopc0zrPRk4YdccIen0nsCmmOpvlfKmJ2+ECVnwjX9KuBn7RHH2oakG0UB0glnQjetpPw8/7SruBx06nYoRDbVBclc1ktOcf8+XYnCbpbQNg33I87pw1sc+cjqI/p97ggVJf0DDmygbT/wLai01CxAiXru79tLtUuXzTQ5GySLPWucQXke2C2JAYxrI4mmKD1wmg91SlKvODI7ux/JZrW0W60/g4OBEX4jeuOz+JG9JYfeCMw2WJPQeIDGXN0N1ofJGGdDrovfJV5AZjgNp20bUnwYk/8hx1jQSxYPu/22KiV2PtVCLc6mE8rRRr6K8Wkmv76p8BsTaAZKjxy2y3Cl1870HNl6tR/QMr82HKggaBapq6hiLMPxMAJJ/YSG2OdbiLAhbFX8e/xrVSq5LlU3Kt7Ko8+MdP7FyS3fQsxPBYiYlSWfQ80FPEpt4wVM6HPXbHq+ZrsCqKZ53DcUeuLCq/TW9QMYw399EesU1iBq2f+94zUR3yUFfknorFcWikVUSHjXum6nnTLCixXgMArOHCvHDHWl+HPP3pqkZa2uTPr5qrdp6MzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199024)(1800799009)(186009)(26005)(83380400001)(6512007)(66446008)(53546011)(6506007)(76116006)(7416002)(2906002)(8936002)(36756003)(15650500001)(54906003)(33656002)(66476007)(44832011)(66946007)(64756008)(41300700001)(4326008)(5660300002)(8676002)(66556008)(316002)(478600001)(71200400001)(38070700005)(86362001)(38100700002)(91956017)(110136005)(122000001)(2616005)(6486002)(66574015)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnJPQTBhd1NKUE5SMUFJM3FzbzlZUlhwNEJ4NklTU1NmVDZORFNMS2ZiWTI4?=
 =?utf-8?B?RS9jbzJ5QnByb3BOLzRnb2hkb2s1NVc2UVdVeVVkSFhUQ2VTOGRoakJPR0hh?=
 =?utf-8?B?MkRTZ0R6cGNDQ085ZzZkVjZkUDZrU0lWeW5xTGhDS0hkME9vUFN2V0FyVEV5?=
 =?utf-8?B?Zkdockl0NTRQZ3pLRFdUYTVUV1VkVVNQMkU1WWVwd1k3akFacDl6VGVIM1lX?=
 =?utf-8?B?anIvK09HU2w4OTZTWUUwZkk0aXpBd3QvRFJTTExMVWZLNXNPa0pBYzJNZzRM?=
 =?utf-8?B?M0dMdE1UMmdxdFpSYXA1Y1AxM0taV1pJZEY0MWdTVmo3Y0R4OXA2ekNqc3Z5?=
 =?utf-8?B?QnVLdk81WHhVV2xWOU1IWWVKQ1hGS01VSkorQW5NVlMybUU0b1NIeng0OHpl?=
 =?utf-8?B?NGRzVE4xakdJTEdPSDRtZ2tyd3NsMUhvbWYvTlk1Myt6R0ZrUDlPODRNT2lK?=
 =?utf-8?B?T1luVHNTcG53Nk5KQ00zdmlHRnEwSXJWU3NJR1IrN1REaGwwWEpITmpOaWpG?=
 =?utf-8?B?cHFzc0NkZnJaNm83RXJDeDFncjRJd01UNE5SaFh0dDkwY3J4SnovYnVINmEy?=
 =?utf-8?B?RHBsZy8wQWhzLzA1T3RGQjZkWGlCYmwxT0JTczEzcUdvRGtPVzNSNVRGVlNp?=
 =?utf-8?B?MUJRNE9tQ1owZExRdnhIQXkzSWFTejFsS01lbU9SQ0pURUEydlNjelhMaVNz?=
 =?utf-8?B?SEhtemhqamNEU2NYUFZFTkZHdklxd2tGbmZMOVAzWVIzNFUrMjNOSVlPUHJT?=
 =?utf-8?B?cXFLUS9Md2RPVWNLaUlEOWJweW1sSTRiVkRla1ZUcTZPRUw5bnlWUE9YdEY2?=
 =?utf-8?B?aWxCQ1BYWWs2N21STFdDQk9DOUZqRHBkYy9MQ2tKN2d5eGJJWEdrSUIza1hV?=
 =?utf-8?B?U0Y5WmhjclpwZ3dQQm5DWnArOEJEbzM1VmU5S0JDZHhuMkh1VlIwU1Y0cmMr?=
 =?utf-8?B?V1ErMHl3WkdrVWZ1MEJYMHFRcHdLZVkyMlErQ0VXcStBMnkrbmp2Tkl0L1hR?=
 =?utf-8?B?bi83TitsSU5hZ1E0VjN3TWszVWtUbTM0akRJNFhaeS9xaDJwZEI4aXdTaDFp?=
 =?utf-8?B?bm9ueVBXK2IydEV3WlNOMWs4M09MWS9yaDNGc21aUlBVMTBDUGN6RDRVVzU2?=
 =?utf-8?B?SS9TUmRRK09WbFpZNXFEK3NRUm5BNGhOQ0g5TzdtTHpjcDU3VFdySDhzSEJQ?=
 =?utf-8?B?ZndqUWZPS1QzdFE5K21DZW9HSU5ZN2dDQVRNN3Jsd0tqWFNPNFVpWmU4R0Qx?=
 =?utf-8?B?SWd1V1M3ZkpSRjlvK0xqRnA3ZE9BcHFLUnJOcU4zeGJBM2xGcS9iOHlRU2lR?=
 =?utf-8?B?bzI3NWlzRHlIZVl0cStPdEM3OWFjN2l3dDJqSXZ3eGpoVFBUTTZ6TEo4eE9s?=
 =?utf-8?B?K1FGNVlBSGN2M2kxSFp2VkpjQVdBY3B6RFBVeWxGeTRqVlpKZG5KbndJL2k0?=
 =?utf-8?B?NGh5NDN5TVJMcStodFBIRzE1bUpmV0dEYVhpOTRqa0VDTGVvM044Qk16Y3lQ?=
 =?utf-8?B?VWlJcUh4OGRlckkxOEZsNS80QXl3SmpJSTJJWE1OS1lnTC9pV3hxbXBGbE5o?=
 =?utf-8?B?cVRsR09xSWQ5SmMzUXJkYVBGYTY0M2NUUDhtSDNENkg0R01WaHBRbWZubzQ5?=
 =?utf-8?B?UEN3NEFHb3dHNWRRNEtHQjUxZXUwWG1lTnNnQW9LZXhpZUEyajdYcTFodmU2?=
 =?utf-8?B?MkZuZ1ZWaEN6L3IwUFBJdHMySktKUWhxbkc1ZjlLOWlydzZFanBvSUZMTVJl?=
 =?utf-8?B?Q01wRWJlRVpVd1UzdDgwOXkrK1NGQnl6aURrQXgyUFFpOHZ1cXJpRVd2ZmJz?=
 =?utf-8?B?WUprKzZNRDI5d3JxRDNyZGZOQ3luQ3hlaVJaUEJtc0lSNnN1TFlScUlXOHVI?=
 =?utf-8?B?MEVUbXJJRTRsakpFOG9vbFZTcTRjdUthNlVTbDBBemxWK3ljbFRnRTlmNDRn?=
 =?utf-8?B?NGtvVEtHdjc3eThPekhYQVR2d3J5bWFmUE13cVYrdE53NnduRFFiNHJ6UnY3?=
 =?utf-8?B?L2gvRHV3dFpkSmhsZWNFbFdsWnNCTDNqNHRWTmE4NGcvb2Z3TjJiendOL1dM?=
 =?utf-8?B?akZ2YW1pYStkQzAxMkVwbHNKL0xCd3I1OWlhUERQRitPTE9MTTFaWU95ejRB?=
 =?utf-8?B?clQyNk11L0p4TC9BNC9SRWoxWVVHMjk4VkJsSUUwY1VEUWFRejdEeWVXL3V1?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E9373FB41F66B41ACE260B9BD528203@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SGYxbElxR1ZEK054blg5L0VWTjdicnRad1F3dmhNR0NIdG1mMmdyd09RdWl3?=
 =?utf-8?B?cXlqK3NCS2tmY2h3TFU2VHBPYmh4NExYTFo0S3NYbkJRemN6RFNrSkNRTS80?=
 =?utf-8?B?L3FkRDkxdDJ1TDlocnFSUHI1a0JYZEt5UXpmNE1QdVhLcllpcTZiTG5pSlFq?=
 =?utf-8?B?RmtMS3RlekxpQlVmSnA4UXpUOVBVUExFN2l2aHVZVm5NeW5UNnBWcHRLWFMx?=
 =?utf-8?B?Wk9ObHM4dWFDckltaXJKUzhUdHh0ekZZMy9qKzdodllkaEh5dGpVemcxQVls?=
 =?utf-8?B?OEJQSFBUdWwrelViQlBTYUR2QW40UjlIVFBPRHZ4SnVUNUZUV1hVNXU4TW1B?=
 =?utf-8?B?am5jUVdacVpoRzF5bFp5UGpxaCtPdjlZTCtnd1AyNkJvNWRzNkhacFFvbk4r?=
 =?utf-8?B?LzBXalpySFByUDhpVXVWcW9CWjc0WXRCY0FPc0twSDRvdnVYSHIxOUkyK21S?=
 =?utf-8?B?djNmclVieUpsK2FCR3NObC9ENWl5ckUrbWdWMENGS1lxbmlmUy83SHI1OUhM?=
 =?utf-8?B?bzNTdVkrZzlIOHcrU1loT1V4STBMT296RitWNkRxeWlIaEV1UE0xUmg4Snhp?=
 =?utf-8?B?QUNGWEwxUlZ0MWlHUCt0dHNpRWMyeVJ2U29rKzBPS3IwOUlOZ1hIQ2F3dW9P?=
 =?utf-8?B?ZGlrYzF1MGxLQ1o0TzdYUjhGOFRTa1FnZEs5cEc4b3RLN1BPNC9KYXpkTjZN?=
 =?utf-8?B?UEsrNmg2M3NJUjg0UTF0TjArSDZrdll2ZktNNGFYS3lwd1I0R29SckpOMFdZ?=
 =?utf-8?B?Y3orUUkrM21uTkdSYmFlOU91L3JqR3RxSEJyWTZadzNtNGk1Q0M1K2tTWnBt?=
 =?utf-8?B?U3BlZDRlS0YvNTZ3bjNJZ01vQXJUT1h0UkIyc0RaZHpTckc1ZUdVYUVMc3ZK?=
 =?utf-8?B?N0tXY1JYL1VHMDF6cVpkdlk3V1F2ckFWU0krNzZiazNkZFRaNTcxbmRscUNR?=
 =?utf-8?B?ZXkray94VmFPN0lhVDR3SE5DcnYzamRZRER5cUYxZVlxU3JFT2dXZGJxS1c2?=
 =?utf-8?B?VXdYUWhUTzd3NFZsVGEybkhyKzRpN1ZwUGNSbjJHbTd1aDhJL3Y5YTVDdDNH?=
 =?utf-8?B?MEVhRnk5Nm5IZUQvaDVBQVgvOFNvWUVOaDJ1VUl5RjJYYnFZeldwclRicUdI?=
 =?utf-8?B?WVkwUVVuUW5RWDRHWFNMVnNLZi84UDJHaVFqQURRc1V3SFg2ZEJZQkYralhD?=
 =?utf-8?B?NEtDVytqcWRNUTRBalJ1UE9FNmwyd0FXUURXdzJEWVNaWS9wL0pCTU92VXhD?=
 =?utf-8?B?ampmYjI2dUFETVZueWc3TTR2dmdSamJPaGVQcjJhOVRtYTNodHpxWktHQlM1?=
 =?utf-8?B?R2lVdVFsUjVKbmlJaEw5cXhTSWtRMnk0Tm53bmNRbHdTbCtEbi9uU3Q2eXNn?=
 =?utf-8?B?WWJheDJGdzBWZkE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 484ea054-1614-47bd-14e8-08dbb314edff
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 22:17:47.6650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I1YjxioUNwohXHAHO2wm5j3LMuPpk4YUarulNgvPeSMjZy6vqRCWqsHot91u2u4CF9c1+nsPYpF2HdRm9VR9E3uMSk8HhpvoJ2V9XcCU12A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6327
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_18,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110205
X-Proofpoint-GUID: oBgI4grOS7cmxcQdwS7cJQJaa-u1lC8H
X-Proofpoint-ORIG-GUID: oBgI4grOS7cmxcQdwS7cJQJaa-u1lC8H
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gU2VwIDExLCAyMDIzLCBhdCAxMDo1MSBBTSwgTWlja2HDq2wgU2FsYcO8biA8bWlj
QGRpZ2lrb2QubmV0PiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgU2VwIDExLCAyMDIzIGF0IDA5OjI5
OjA3QU0gLTA0MDAsIE1pbWkgWm9oYXIgd3JvdGU6DQo+PiBIaSBFcmljLA0KPj4gDQo+PiBPbiBG
cmksIDIwMjMtMDktMDggYXQgMTc6MzQgLTA0MDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+Pj4g
Q3VycmVudGx5IHJvb3QgY2FuIGR5bmFtaWNhbGx5IHVwZGF0ZSB0aGUgYmxhY2tsaXN0IGtleXJp
bmcgaWYgdGhlIGhhc2gNCj4+PiBiZWluZyBhZGRlZCBpcyBzaWduZWQgYW5kIHZvdWNoZWQgZm9y
IGJ5IHRoZSBidWlsdGluIHRydXN0ZWQga2V5cmluZy4NCj4+PiBDdXJyZW50bHkga2V5cyBpbiB0
aGUgc2Vjb25kYXJ5IHRydXN0ZWQga2V5cmluZyBjYW4gbm90IGJlIHVzZWQuDQo+Pj4gDQo+Pj4g
S2V5cyB3aXRoaW4gdGhlIHNlY29uZGFyeSB0cnVzdGVkIGtleXJpbmcgY2FycnkgdGhlIHNhbWUg
Y2FwYWJpbGl0aWVzIGFzDQo+Pj4gdGhlIGJ1aWx0aW4gdHJ1c3RlZCBrZXlyaW5nLiAgUmVsYXgg
dGhlIGN1cnJlbnQgcmVzdHJpY3Rpb24gZm9yIHVwZGF0aW5nDQo+Pj4gdGhlIC5ibGFja2xpc3Qg
a2V5cmluZyBhbmQgYWxsb3cgdGhlIHNlY29uZGFyeSB0byBhbHNvIGJlIHJlZmVyZW5jZWQgYXMN
Cj4+PiBhIHRydXN0IHNvdXJjZS4gIFNpbmNlIHRoZSBtYWNoaW5lIGtleXJpbmcgaXMgbGlua2Vk
IHRvIHRoZSBzZWNvbmRhcnkNCj4+PiB0cnVzdGVkIGtleXJpbmcsIGFueSBrZXkgd2l0aGluIGl0
IG1heSBhbHNvIGJlIHVzZWQuDQo+Pj4gDQo+Pj4gQW4gZXhhbXBsZSB1c2UgY2FzZSBmb3IgdGhp
cyBpcyBJTUEgYXBwcmFpc2FsLiAgTm93IHRoYXQgSU1BIGJvdGgNCj4+PiByZWZlcmVuY2VzIHRo
ZSBibGFja2xpc3Qga2V5cmluZyBhbmQgYWxsb3dzIHRoZSBtYWNoaW5lIG93bmVyIHRvIGFkZA0K
Pj4+IGN1c3RvbSBJTUEgQ0EgY2VydHMgdmlhIHRoZSBtYWNoaW5lIGtleXJpbmcsIHRoaXMgYWRk
cyB0aGUgYWRkaXRpb25hbA0KPj4+IGNhcGFiaWxpdHkgZm9yIHRoZSBtYWNoaW5lIG93bmVyIHRv
IGFsc28gZG8gcmV2b2NhdGlvbnMgb24gYSBydW5uaW5nDQo+Pj4gc3lzdGVtLg0KPj4+IA0KPj4+
IElNQSBhcHByYWlzYWwgdXNhZ2UgZXhhbXBsZSB0byBhZGQgYSByZXZvY2F0aW9uIGZvciAvdXNy
L2ZvbzoNCj4+PiANCj4+PiBzaGEyNTZzdW0gL2Jpbi9mb28gfCBhd2sgJ3twcmludGYgImJpbjoi
ICQxfScgPiBoYXNoLnR4dA0KPj4+IA0KPj4+IG9wZW5zc2wgc21pbWUgLXNpZ24gLWluIGhhc2gu
dHh0IC1pbmtleSBtYWNoaW5lLXByaXZhdGUta2V5LnBlbSBcDQo+Pj4gICAgICAgLXNpZ25lciBt
YWNoaW5lLWNlcnRpZmljYXRlLnBlbSAtbm9hdHRyIC1iaW5hcnkgLW91dGZvcm0gREVSIFwNCj4+
PiAgICAgICAtb3V0IGhhc2gucDdzDQo+Pj4gDQo+Pj4ga2V5Y3RsIHBhZGQgYmxhY2tsaXN0ICIk
KDwgaGFzaC50eHQpIiAlOi5ibGFja2xpc3QgPCBoYXNoLnA3cw0KPj4+IA0KPj4+IFNpZ25lZC1v
ZmYtYnk6IEVyaWMgU25vd2JlcmcgPGVyaWMuc25vd2JlcmdAb3JhY2xlLmNvbT4NCj4+IA0KPj4g
VGhlIHNlY29uZGFyeSBrZXlyaW5nIG1heSBpbmNsdWRlIGJvdGggQ0EgYW5kIGNvZGUgc2lnbmlu
ZyBrZXlzLiAgV2l0aA0KPj4gdGhpcyBjaGFuZ2UgYW55IGtleSBsb2FkZWQgb250byB0aGUgc2Vj
b25kYXJ5IGtleXJpbmcgbWF5IGJsYWNrbGlzdCBhDQo+PiBoYXNoLiAgV291bGRuJ3QgaXQgbWFr
ZSBtb3JlIHNlbnNlIHRvIGxpbWl0IGJsYWNrbGlzdGluZw0KPj4gY2VydGlmaWNhdGVzL2hhc2hl
cyB0byBhdCBsZWFzdCBDQSBrZXlzPyANCj4gDQo+IFNvbWUgb3BlcmF0aW9uYWwgY29uc3RyYWlu
dHMgbWF5IGxpbWl0IHdoYXQgYSBDQSBjYW4gc2lnbi4NCg0KQWdyZWVkLiAgDQoNCklzIHRoZXJl
IHByZWNlZGVudHMgZm9yIHJlcXVpcmluZyB0aGlzIFMvTUlNRSB0byBiZSBzaWduZWQgYnkgYSBD
QT8gDQoNCj4gVGhpcyBjaGFuZ2UgaXMgY3JpdGljYWwgYW5kIHNob3VsZCBiZSB0aWVkIHRvIGEg
ZGVkaWNhdGVkIGtlcm5lbCBjb25maWcNCj4gKGRpc2FibGVkIGJ5IGRlZmF1bHQpLCBvdGhlcndp
c2UgZXhpc3Rpbmcgc3lzdGVtcyB1c2luZyB0aGlzIGZlYXR1cmUNCj4gd2lsbCBoYXZlIHRoZWly
IHRocmVhdCBtb2RlbCBhdXRvbWF0aWNhbGx5IGNoYW5nZWQgd2l0aG91dCBub3RpY2UuDQoNClRv
ZGF5IHdlIGhhdmUgSU5URUdSSVRZX0NBX01BQ0hJTkVfS0VZUklOR19NQVguICBUaGlzIGNhbiAN
CmJlIGVuYWJsZWQgdG8gZW5mb3JjZSBDQSByZXN0cmljdGlvbnMgb24gdGhlIG1hY2hpbmUga2V5
cmluZy4gIE1pbWksIHdvdWxkIA0KdGhpcyBiZSBhIHN1aXRhYmxlIHNvbHV0aW9uIGZvciB3aGF0
IHlvdSBhcmUgYWZ0ZXI/DQoNCkkgc3VwcG9zZSByb290IGNvdWxkIGFkZCBhbm90aGVyIGtleSB0
byB0aGUgc2Vjb25kYXJ5IGtleXJpbmcgaWYgaXQgd2FzIA0Kc2lnbmVkIGJ5IGEga2V5IGluIHRo
ZSBtYWNoaW5lIGtleXJpbmcuICBCdXQgdGhlbiB3ZSBhcmUgZ2V0dGluZyBpbnRvIGFuIA0KYXJl
YSBvZiBrZXkgdXNhZ2UgZW5mb3JjZW1lbnQgd2hpY2ggcmVhbGx5IG9ubHkgZXhpc3RzIGZvciB0
aGluZ3MgYWRkZWQgDQp0byB0aGUgLmltYSBrZXlyaW5nLiANCg0KPj4+IC0tLQ0KPj4+IGNlcnRz
L0tjb25maWcgICAgIHwgMiArLQ0KPj4+IGNlcnRzL2JsYWNrbGlzdC5jIHwgNCArKy0tDQo+Pj4g
MiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pj4gDQo+
Pj4gZGlmZiAtLWdpdCBhL2NlcnRzL0tjb25maWcgYi9jZXJ0cy9LY29uZmlnDQo+Pj4gaW5kZXgg
MWYxMDliMDcwODc3Li4yM2RjODdjNTJhZmYgMTAwNjQ0DQo+Pj4gLS0tIGEvY2VydHMvS2NvbmZp
Zw0KPj4+ICsrKyBiL2NlcnRzL0tjb25maWcNCj4+PiBAQCAtMTM0LDcgKzEzNCw3IEBAIGNvbmZp
ZyBTWVNURU1fQkxBQ0tMSVNUX0FVVEhfVVBEQVRFDQo+Pj4gCWRlcGVuZHMgb24gU1lTVEVNX0RB
VEFfVkVSSUZJQ0FUSU9ODQo+Pj4gCWhlbHANCj4+PiAJICBJZiBzZXQsIHByb3ZpZGUgdGhlIGFi
aWxpdHkgdG8gbG9hZCBuZXcgYmxhY2tsaXN0IGtleXMgYXQgcnVuIHRpbWUgaWYNCj4+PiAtCSAg
dGhleSBhcmUgc2lnbmVkIGFuZCB2b3VjaGVkIGJ5IGEgY2VydGlmaWNhdGUgZnJvbSB0aGUgYnVp
bHRpbiB0cnVzdGVkDQo+Pj4gKwkgIHRoZXkgYXJlIHNpZ25lZCBhbmQgdm91Y2hlZCBieSBhIGNl
cnRpZmljYXRlIGZyb20gdGhlIHNlY29uZGFyeSB0cnVzdGVkDQo+PiANCj4+IElmIENPTkZJR19T
RUNPTkRBUllfVFJVU1RFRF9LRVlSSU5HIGlzIG5vdCBlbmFibGVkLCBpdCBmYWxscyBiYWNrIHRv
DQo+PiB0aGUgYnVpbHRpbiBrZXlyaW5nLiAgUGxlYXNlIHVwZGF0ZSB0aGUgY29tbWVudCBhY2Nv
cmRpbmdseS4NCg0KSeKAmWxsIGZpeCB0aGVzZSBpbiB0aGUgbmV4dCByb3VuZCwgdGhhbmtzLg0K
DQo=
