Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7427AD69F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjIYLEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 07:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjIYLEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:04:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CA8AB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 04:04:31 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PABfTg011958;
        Mon, 25 Sep 2023 11:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MZNJuvFF6qEXO4gVn+fqRuVzXSWct+WFqZayHcbRcHM=;
 b=kVfogp+hrPI1XKx5xirpVzPMB7HDfKmWFtJKAHnPG4OPCi3c/RF9Msx+QfZ2cwfUGUbY
 OSq7b4RFaTZfzj2tsLE0mta6YTwtBH8+yWmHcmAuNuo6kAoQ3fVQsOJMhftFvcmEJVCe
 DuZEr95u62FUC7QJ5eWMH3+KnZyEdB1pnzoobXjrZhshPe1NhM7PTbH6j4Bu9g9BYJJq
 X4JKKmOLyM2DsIB14UmoJx/0fD0sfh4lts8yALQ9S+DZT6tTyCt1dIrpln0spau16kUI
 ZC4NvmlrAnCtPAY/b8v473iPXNqr6AFl5uk5Nq0zH3Z2lDYwxO668X4emXasRhOorlC2 2Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pm23egy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 11:04:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38P9t7CC031012;
        Mon, 25 Sep 2023 11:04:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfacc6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 11:04:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/SaRDNsQ9aOUkTbALBGkMbvywtnhRitziBIKr8tF15s2dbg1XEDUopEqWEgpKqW/Lz6mYj+jF25K8n1Fe+qkth7mQxZsNReKrsiTjVi8DkAo6taRR/1oH3Lrk/OYCY74zcbW2XS8JHhfibJYYv16gUD+pKG7HMERVDhQMYRAVekxmnmJyuF/UxTLRKtyI+smn+Njbw7C3W3/6joYQ8J+jcnm4j6/rqMhfnFKnP+ufdCQ5Je5kT8iQDirSf0rNh8pmbrWjvFPZUegCG89og3XEdq+FqmvNNkaO1M+oSa+LwJmO/7U6TFeHSekBfgg2ieJ6JAC9PD0iXrJCd90QWpNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZNJuvFF6qEXO4gVn+fqRuVzXSWct+WFqZayHcbRcHM=;
 b=Mu3JhxXE0LTe7EEpZbIlxCGwNiYBFuGkJkVRroSi/lGAFjjjOlxHUhhrKz/jcV/EWDd0UD5bUYtCSyKarSEtSWDQKfW1epwHodyfNOV1czVh735TURqvwfyPrpS4NvKi3hFOhKBNZpyWBwy9hBzNiwNrTF09+Xm01AQH+0EMFbbD/L4lWT4CNp5QRUMOTM6g5J24qLmbM7PbtmligFueJkBHYFrglW5HXigka2hzKdbOI1a1ip3z8vICCLEN+OzRi480jtagatFtzeSUfCHk+2fBMYKkZIeKHMsjONd3I3bF/sI8k3GOVin8YyC6z/zOXfoRrzIKQGiZ4K8k4A4LPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZNJuvFF6qEXO4gVn+fqRuVzXSWct+WFqZayHcbRcHM=;
 b=K7PnA/gHqmSGqrrbg7g1sJ3Ygsrli2fAJ5/1MkF6o0/Qskf2E9U5/rbltPvad0fNr5kbPis7v7yYjZUlp+VwXIkkmReYzmhUuv/iD/KarCtG3Zf4ACjGs/Q+FKeUP/H4ZhcqlwPCTSS3QWwoJ+mTkAteBO/B64LuNfEJHKk+nbA=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by PH0PR10MB7098.namprd10.prod.outlook.com (2603:10b6:510:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 11:04:08 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::76c:cb31:2005:d10c]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::76c:cb31:2005:d10c%5]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 11:04:07 +0000
From:   Miguel Luis <miguel.luis@oracle.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>
Subject: Re: [PATCH 3/3] KVM: arm64: nv: Handle all _EL02 and _EL12 registers
Thread-Topic: [PATCH 3/3] KVM: arm64: nv: Handle all _EL02 and _EL12 registers
Thread-Index: AQHZ5nOMBvQnuUHm90CBvgZS5x/04LAgXHOAgAAxjwCAAARFgIAK4MWA
Date:   Mon, 25 Sep 2023 11:04:07 +0000
Message-ID: <9D7F3DC3-9AB4-4FDB-9E9F-B491D3350392@oracle.com>
References: <20230913185209.32282-1-miguel.luis@oracle.com>
 <20230913185209.32282-4-miguel.luis@oracle.com>
 <867conerys.wl-maz@kernel.org>
 <4A24B4EC-B221-48B6-BA91-DB7AC72CAA8D@oracle.com>
 <861qevej1o.wl-maz@kernel.org>
In-Reply-To: <861qevej1o.wl-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|PH0PR10MB7098:EE_
x-ms-office365-filtering-correlation-id: 69111911-a09a-46db-512c-08dbbdb723ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hj3Oo9u17dsNkq/E0R3ahB/wEiTSTGSNVyoCxaOYaOXzzZI6A72uatypi4kyxCcxqXUTdQ983xGzqziNo6UHWfhSCtXvjqvZKxrzMLC/CEnuWZabimMKp3QLDapPypC1r1S6/asifk1v8VVVPmFZ8tmNABUrUMZe0seIh4ARkI517mbnqmUs5E4LU9k9kjy6LnakzP7yDCD5SY0TGuH6Zfx/j3jN4yDe6WEuTWCoyj3+LNM8q+VOPrBG1GTgz2c0NIuNCEX5/71xw06w46uhl57oSu8LKAM9U8fVsagP1hyurjayIbuE1ne7vLtZOno2oVRCWJBJF6tyApymJEQflzeXbYKjrhlDFpnr/Oq6K9hh+3JGIv4TB7/MAqx0PuMwZnpuuyoXTqZsFpawbjfPm4+do7tbYQ1PGcQt2RO85Lt3x+C9DwhV0s+Jb6WIHqr2mFQDPhhriYIOx2ddg5PFBp2T+mGVCB6LX2ft9kRz/YpRd/jU9sVX2MpZtxzTZep3/xsq7SnNW9J1SI84MoAiCcqy0AQLauKyY+wx8jWHB5nIFaYYUy605mqJ5ywtitbiguDtfSFLBoSJxQu8ZHhh7KGQ1UDFm1Q7q8y8oe/h20hsWWvz8p+dMefngivyHsqPt59UJ2Kg3pOKBw3TpW1UYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(186009)(1800799009)(451199024)(38070700005)(36756003)(33656002)(38100700002)(86362001)(53546011)(2906002)(2616005)(5660300002)(66476007)(478600001)(41300700001)(316002)(66556008)(76116006)(54906003)(64756008)(66446008)(6916009)(91956017)(66946007)(122000001)(44832011)(7416002)(6506007)(6486002)(71200400001)(6512007)(83380400001)(4326008)(8676002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGh1d0FWbGpIdnFHeHlVV2wxNVMzQkVkajRLUjFoZ0NJbnMyUENJaXRkVmFI?=
 =?utf-8?B?VnhDQnJocGNGbkliUm1oMDVGTWlzL04zblg1OVluSUp6SXZjT2ZhcklRUXZK?=
 =?utf-8?B?TEhXcExkSThTTTRlTnZtVWVhTDlYWUlEKytOUjUxTEtBWTNsNmo3bGZwZnRi?=
 =?utf-8?B?WVNabFp4emdoM3BwSmpya0NDcDZaaXVEMDVkcHU1bmRmTFZTUEZrbjlQWm1Y?=
 =?utf-8?B?U25XMDREVExMSk5xZDVPcFBsTWJweStKbi9jWWVJay9hQXA5WUVZZGE5U0JM?=
 =?utf-8?B?NVF0a084SysyUVJCQmZnU04yeWRTd1VJQWhFdWxjUXN3Qyt0QWZOcldhZjYw?=
 =?utf-8?B?WkNWdDJKQnZvSVFLVXF3eUJzMHNDc0RiYVFnbnB0RXViRVIyclM3VVVia3lW?=
 =?utf-8?B?RzJKaGwvQi9CVWtOMVhRMW1LQ0UxSFBhdHhBQVozeUhhcVVUTnU0Z0ticDBL?=
 =?utf-8?B?QXV0bUJHT2pWUjR4M3E5MTZyVEJyNFBleEE3NlhSZEZIU0hPMHY4Y1RZdUhL?=
 =?utf-8?B?V1RCVnN0TExlOEEyT1JPT3VZbGNYdGFTcE9wTUV6WHY4SkVQVmpDM0lVWkhD?=
 =?utf-8?B?N2pxTGl0OVdZV2hYS1Z2SlE4dVpCUFYxNzZheWpKdGYvamluZ0ZzSHZSL1NJ?=
 =?utf-8?B?NEZhWDdod0RKNVp3RmVMRWpyK3U4aHB6eldwQ3RYbGt5RWlQMzgvdXFPeTh3?=
 =?utf-8?B?UTlaSzhGNTNxTTlLT1NqYTZ5MytleEQxY2lieFRORVIzVjBrdTNCTGxON1Vh?=
 =?utf-8?B?TzRGSWwrMlc3REg4UmlMY1B3ZWhybFJqckpZdE1LVGFNSTFuNmVkUWQrZlYw?=
 =?utf-8?B?NUZIcmxINUtoRmNSVklZTlpTTGM1QWNrYWttaU9IYXZjTjQwZFJpZnk2dWNU?=
 =?utf-8?B?TjY2bXQvd2VmYmJ1UXBYc2F3NU43MkFCakFoQnZST0FRSzdGNDBicUFqVUZM?=
 =?utf-8?B?ZXVaZHFTeTlLOUdtYktGNDNLak9zM01LNUlzRi9NZUl1QVgrZWVHV1VGN0xt?=
 =?utf-8?B?cDFzNEZQWHEybkI3V0Npelk1Z3dzQ3pkaUdOUDhzaENLNFNYUFNLOEx4Q3RY?=
 =?utf-8?B?N0gwZ3B6SitOZTFPUGl5a2laNHRxWFEvVllwMHphL0xnSVY5dGF6Mkh6OU5P?=
 =?utf-8?B?R0FTSU8wb1VPb014bTU5YUt2QWIwMkNhUDE4YnphWlBlSFk3STlOc3J5RC9q?=
 =?utf-8?B?dnJwdUMvWGRZUmdSTkFTSWk1WitIeUg2YmFoNlVRMXZVZmdIYVhqWXFGZ01T?=
 =?utf-8?B?VXNGM08xWXgwbjdaQ0pPQW94WGVnNWdLQjF5MUE3M1Q2QzF6STZUd00yRmZS?=
 =?utf-8?B?Lyswc0xoRkhWN3N0akNWOEUvbWIxalRnNW5QSEk3Tm5objM5WW9uaWlJbG1w?=
 =?utf-8?B?aGRaUldEb0tCcHdlZG9oM2RoY3FWem8vQUJobzlVdCtmam9XQXN5TjMrNHMv?=
 =?utf-8?B?MlVKVTVNazNZZ05qRXlXWXU5OCtMd0VWdUNRMEx3Y0FLQ3RlaGZLTEQ4Q2I5?=
 =?utf-8?B?M3pKYm5Ob1lhWnZmYSttUS9ERXBOMzRIbHBVd0thK1BVVDU2TFFaaE4xYlAv?=
 =?utf-8?B?R0h4SXpXd1hwZTg4NFJlWnJFY2hZV2t1bEZTejFYYjNHbGVqVDFoME1VSXNt?=
 =?utf-8?B?ZGc0MDBtUWpVbG05TVd0d0swc2ZjL2pSM0ttYlRSaVRjTURHRVdmZFNtczhW?=
 =?utf-8?B?bXEyTDdXNTQ2N0tIeUFWYmV5SDRNUWsxYzRsMTBpb3Z1amp5M1dVcjFPRyt5?=
 =?utf-8?B?d29HNWQyaERxUDZCcnNiYmZiTGs1aGtiMXRSYUQwaGVCWUM1RjdzY0RwU3Uw?=
 =?utf-8?B?UWM1RGszZ3BSTDBtZDVmdzZjakdlNlRnazd0aDRpTnB4emhYQzZaRjJWVlBs?=
 =?utf-8?B?czRQbURUb0UxL0h1SnNPWTF2VGlsQk91dWw1ZU1JQWRHQ2lQbk1xZ2Z1YnNC?=
 =?utf-8?B?T0ZPT1J3TmdGSnQ4VDl1eGxJNmViaWtDMThLRmljZmFPWjJrNHJoZFQ1azFt?=
 =?utf-8?B?TzVoSXlQMzlGSnhQNkR6ZWNub2ZyRklRSUk3Ymlkd2ZhZitIR0o3WWNsRUJw?=
 =?utf-8?B?QnB3WmZPZU0zT3p3MUJqMy8wbG5JZFIzejh0S2ZXVURoRGFYS2Q4WGxVT0N0?=
 =?utf-8?B?TmFpdnBPRnRtZ1ozQmdQa1ZaTklZMnpYT2NSTzVSUkVaM3paSkMxc2NTMUM2?=
 =?utf-8?Q?SqOOMesF6gJLKTaY/Xvyuvg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD71383CE58CBA4F846011F9054DD7B5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UERnWXA1eW1paU5PYjJaeUZqUUZ4RFMrYTA0RTZFZFBHNXYzejNtREJtMmN1?=
 =?utf-8?B?QjJZS2xCWVN4QksxUFNIL0loVEI0YWFWSVhQcWQxSHNrT0hVUTVKaUpUdWhH?=
 =?utf-8?B?d1VPR09aTk1NVE9IQlNSbDlqdVp6L2xpWm1xSGl4N2U0WWl3NkNOemp0NVFj?=
 =?utf-8?B?RUtERTh1dUFpbmJPcUt2cm5adzVsdGs1cFpUTE02V1NNWXhnNS9XalBuaW9U?=
 =?utf-8?B?OFRzT3c5MWNZUHdhMVVYMGRtMHN6aTRBLzF5WFZtcWlMZHVSQjdMMFBvajFN?=
 =?utf-8?B?TjVua2pEYXkzSy96ekVjRVRHWkJjRnNQMUlvSTJZK0YySXI3WkRRR0lUaHZT?=
 =?utf-8?B?M3p2T0JWQWRBeGxEaDl2TndCMExvalFQais2aXBHR1B0eHlYcitxdGlIK243?=
 =?utf-8?B?NHNYcHZqL29kd3F0WlpHcDRPRzhRRVM1UlF6UDJFRVBPVnBRRjNKSkpTRjdO?=
 =?utf-8?B?UnMwb3Y2enNxaUx4dFB0Ym9rNy84aVlJakVERVFXU3pkQzhRZUFlcjI2VDh1?=
 =?utf-8?B?TFI1VnQ4eWxvc085ZzZnenNUZGx5UlV0S1RVZ1JHSmNmS1prU3dFTFhxb1BO?=
 =?utf-8?B?Z005dkY0S0VnV1BmTnZ0NGhoMnV2QnRSMnkzWmdLc0FUeU9ndklCSnhQNlFB?=
 =?utf-8?B?dkpnbXBKU2hJQ3hJWnkxTVlyU0NGWGM1V1NIM1ViL0JiTVhuQ21nbVIxT1lw?=
 =?utf-8?B?QTBoYURGeG5uVFVwMVhHN2JxVHlXTjd6NjBESkF4Q2tOVDBiV1hFS2l5R0Ni?=
 =?utf-8?B?a2lmNmh1Y0JYS2tvbEh6R1RCZXl6bFBqN0wvNGhIY1lJOEh0SGdOMFpVWHhs?=
 =?utf-8?B?OUxpNnAvd0RuYUEwYWlCQTRHY0JsMGxVdlRJWGViTGlHOFJ5bWE1OUdSdHZY?=
 =?utf-8?B?UjV0QXkvSFVacnFJNW91eldJbE4rOFNFRng5WkZ5S3REd216NVBLU2ZCWEht?=
 =?utf-8?B?d2RaODJRdXY1bHBqeGcwczlGVzVFdTJiekZURlhGMkFOWDVhc3dqdWFKUmVJ?=
 =?utf-8?B?cnhIWHlQaElNcElGRGYweE1nOVhodTlSTEF5R1FiT01TcUxuVDkxUlZnejBy?=
 =?utf-8?B?NWhFTFVta0tyQ0RObmRQRzhJeldyY2FUOVhVSkRYWXltSzh0cUJ0UVp0QmlT?=
 =?utf-8?B?NmswUElnL3EzNk1vRzlBRG1RbVBCY0h0MVp3SFJ0N01QYlp5aEVWQ0ZNbWVJ?=
 =?utf-8?B?WG0xU1J4a3Nyb3ZNR09vY3pzQ1JIYmdJQUNEendJdy9PMEZPdHVFbUtUWWxC?=
 =?utf-8?B?RFpENWM5ei9lUkw2TDNmY1BKeDQ5V2FSUEZUUXFTOUNnZTdjQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69111911-a09a-46db-512c-08dbbdb723ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 11:04:07.7808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +9Ii8WvgdZ02WLkgq7YVnKBh9hKHbhaKBXEPWSaKU0t6dimvVO7LeP7WYwvq0QKKCvwjIK5QqaShLn5pjodBMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_08,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250082
X-Proofpoint-ORIG-GUID: IWx_Ybg9YCJDOnJz5vEAkhbcvcM7FG7W
X-Proofpoint-GUID: IWx_Ybg9YCJDOnJz5vEAkhbcvcM7FG7W
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyYywNCg0KPiBPbiAxOCBTZXAgMjAyMywgYXQgMTI6NTYsIE1hcmMgWnluZ2llciA8bWF6
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gTW9uLCAxOCBTZXAgMjAyMyAxMzo0MTo0NSAr
MDEwMCwNCj4gTWlndWVsIEx1aXMgPG1pZ3VlbC5sdWlzQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4g
DQo+PiBIaSBNYXJjLA0KPj4gDQo+Pj4gT24gMTggU2VwIDIwMjMsIGF0IDA5OjQ0LCBNYXJjIFp5
bmdpZXIgPG1hekBrZXJuZWwub3JnPiB3cm90ZToNCj4+PiANCj4+PiBPbiBXZWQsIDEzIFNlcCAy
MDIzIDE5OjUyOjA4ICswMTAwLA0KPj4+IE1pZ3VlbCBMdWlzIDxtaWd1ZWwubHVpc0BvcmFjbGUu
Y29tPiB3cm90ZToNCj4+Pj4gDQo+Pj4+IFNwZWNpZnkgYm90aCBfRUwwMiBhbmQgX0VMMTIgc3lz
dGVtIHJlZ2lzdGVycy4NCj4+Pj4gDQo+Pj4+IFNpZ25lZC1vZmYtYnk6IE1pZ3VlbCBMdWlzIDxt
aWd1ZWwubHVpc0BvcmFjbGUuY29tPg0KPj4+PiAtLS0NCj4+Pj4gYXJjaC9hcm02NC9rdm0vZW11
bGF0ZS1uZXN0ZWQuYyB8IDM1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPj4+
PiAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+Pj4g
DQo+Pj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2t2bS9lbXVsYXRlLW5lc3RlZC5jIGIvYXJj
aC9hcm02NC9rdm0vZW11bGF0ZS1uZXN0ZWQuYw0KPj4+PiBpbmRleCA5YWExYzA2YWJkYjcuLjk1
N2FmZDk3ZTQ4OCAxMDA2NDQNCj4+Pj4gLS0tIGEvYXJjaC9hcm02NC9rdm0vZW11bGF0ZS1uZXN0
ZWQuYw0KPj4+PiArKysgYi9hcmNoL2FybTY0L2t2bS9lbXVsYXRlLW5lc3RlZC5jDQo+Pj4+IEBA
IC02OTAsMTAgKzY5MCwzNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGVuY29kaW5nX3RvX3RyYXBf
Y29uZmlnIGVuY29kaW5nX3RvX2NndFtdIF9faW5pdGNvbnN0ID0gew0KPj4+PiBTUl9SQU5HRV9U
UkFQKHN5c19yZWcoMywgNCwgMTQsIDAsIDMpLA0KPj4+PiBzeXNfcmVnKDMsIDQsIDE0LCA1LCAy
KSwgQ0dUX0hDUl9OViksDQo+Pj4+IC8qIEFsbCBfRUwwMiwgX0VMMTIgcmVnaXN0ZXJzICovDQo+
Pj4+IC0gU1JfUkFOR0VfVFJBUChzeXNfcmVnKDMsIDUsIDAsIDAsIDApLA0KPj4+PiAtICAgICAg
IHN5c19yZWcoMywgNSwgMTAsIDE1LCA3KSwgQ0dUX0hDUl9OViksDQo+Pj4+IC0gU1JfUkFOR0Vf
VFJBUChzeXNfcmVnKDMsIDUsIDEyLCAwLCAwKSwNCj4+Pj4gLSAgICAgICBzeXNfcmVnKDMsIDUs
IDE0LCAxNSwgNyksIENHVF9IQ1JfTlYpLA0KPj4+PiArIFNSX1RSQVAoU1lTX1NDVExSX0VMMTIs
IENHVF9IQ1JfTlYpLA0KPj4+PiArIFNSX1RSQVAoU1lTX0NQQUNSX0VMMTIsIENHVF9IQ1JfTlYp
LA0KPj4+PiArIFNSX1RSQVAoU1lTX1NDVExSMl9FTDEyLCBDR1RfSENSX05WKSwNCj4+Pj4gKyBT
Ul9UUkFQKFNZU19aQ1JfRUwxMiwgQ0dUX0hDUl9OViksDQo+Pj4+ICsgU1JfVFJBUChTWVNfVFJG
Q1JfRUwxMiwgQ0dUX0hDUl9OViksDQo+Pj4+ICsgU1JfVFJBUChTWVNfU01DUl9FTDEyLCBDR1Rf
SENSX05WKSwNCj4+Pj4gKyBTUl9UUkFQKFNZU19UVEJSMF9FTDEyLCBDR1RfSENSX05WKSwNCj4+
Pj4gKyBTUl9UUkFQKFNZU19UVEJSMV9FTDEyLCBDR1RfSENSX05WKSwNCj4+Pj4gKyBTUl9UUkFQ
KFNZU19UQ1JfRUwxMiwgQ0dUX0hDUl9OViksDQo+Pj4+ICsgU1JfVFJBUChTWVNfVENSMl9FTDEy
LCBDR1RfSENSX05WKSwNCj4+Pj4gKyBTUl9UUkFQKFNZU19TUFNSX0VMMTIsIENHVF9IQ1JfTlYp
LA0KPj4+PiArIFNSX1RSQVAoU1lTX0VMUl9FTDEyLCBDR1RfSENSX05WKSwNCj4+Pj4gKyBTUl9U
UkFQKFNZU19BRlNSMF9FTDEyLCBDR1RfSENSX05WKSwNCj4+Pj4gKyBTUl9UUkFQKFNZU19BRlNS
MV9FTDEyLCBDR1RfSENSX05WKSwNCj4+Pj4gKyBTUl9UUkFQKFNZU19FU1JfRUwxMiwgQ0dUX0hD
Ul9OViksDQo+Pj4+ICsgU1JfVFJBUChTWVNfVEZTUl9FTDEyLCBDR1RfSENSX05WKSwNCj4+Pj4g
KyBTUl9UUkFQKFNZU19GQVJfRUwxMiwgQ0dUX0hDUl9OViksDQo+Pj4+ICsgU1JfVFJBUChTWVNf
QlJCQ1JfRUwxMiwgQ0dUX0hDUl9OViksDQo+Pj4+ICsgU1JfVFJBUChTWVNfUE1TQ1JfRUwxMiwg
Q0dUX0hDUl9OViksDQo+Pj4+ICsgU1JfVFJBUChTWVNfTUFJUl9FTDEyLCBDR1RfSENSX05WKSwN
Cj4+Pj4gKyBTUl9UUkFQKFNZU19BTUFJUl9FTDEyLCBDR1RfSENSX05WKSwNCj4+Pj4gKyBTUl9U
UkFQKFNZU19WQkFSX0VMMTIsIENHVF9IQ1JfTlYpLA0KPj4+PiArIFNSX1RSQVAoU1lTX0NPTlRF
WFRJRFJfRUwxMiwgQ0dUX0hDUl9OViksDQo+Pj4+ICsgU1JfVFJBUChTWVNfU0NYVE5VTV9FTDEy
LCBDR1RfSENSX05WKSwNCj4+Pj4gKyBTUl9UUkFQKFNZU19DTlRLQ1RMX0VMMTIsIENHVF9IQ1Jf
TlYpLA0KPj4+PiArIFNSX1RSQVAoU1lTX0NOVFBfVFZBTF9FTDAyLCBDR1RfSENSX05WKSwNCj4+
Pj4gKyBTUl9UUkFQKFNZU19DTlRQX0NUTF9FTDAyLCBDR1RfSENSX05WKSwNCj4+Pj4gKyBTUl9U
UkFQKFNZU19DTlRQX0NWQUxfRUwwMiwgQ0dUX0hDUl9OViksDQo+Pj4+ICsgU1JfVFJBUChTWVNf
Q05UVl9UVkFMX0VMMDIsIENHVF9IQ1JfTlYpLA0KPj4+PiArIFNSX1RSQVAoU1lTX0NOVFZfQ1RM
X0VMMDIsIENHVF9IQ1JfTlYpLA0KPj4+PiArIFNSX1RSQVAoU1lTX0NOVFZfQ1ZBTF9FTDAyLCBD
R1RfSENSX05WKSwNCj4+Pj4gU1JfVFJBUChPUF9BVF9TMUUyUiwgQ0dUX0hDUl9OViksDQo+Pj4+
IFNSX1RSQVAoT1BfQVRfUzFFMlcsIENHVF9IQ1JfTlYpLA0KPj4+PiBTUl9UUkFQKE9QX0FUX1Mx
MkUxUiwgQ0dUX0hDUl9OViksDQo+Pj4gDQo+Pj4gV2hpbGUgSSBjb3VsZCBzZWUgdGhlIHByb2Js
ZW0gd2l0aCB0aGUgRUwyIHJlZ2lzdGVycywgSSdtIG5vdA0KPj4+IGNvbnZpbmNlZCBieSB0aGlz
IHBhdGNoLiBJcyB0aGVyZSBhbiBhY3R1YWwgY2FzZSBmb3Igbm9uIF9FTDAyLCBub24NCj4+PiBf
RUwxMiByZWdpc3RlcnMgdGhhdCBhcmUgaW5jbHVkZWQgaW4gdGhlIHR3byByYW5nZXMgYWJvdmU/
DQo+Pj4gDQo+PiANCj4+IEhhdmluZyBEREkwNDg3SmEgYXMgcmVmZXJlbmNlLCB0aGVyZSBpcyBu
b25lLiBJdCBpcyBub3QgY2xlYXIgdG8gbWUgaGF2aW5nIHR3bw0KPj4gc2VwYXJhdGUgcmFuZ2Vz
LiBJZiBpdCBpcyB0byBjb3ZlciBfRUwwMiBhbmQgX0VMMTIgcmFuZ2VzIHNlcGFyYXRlbHkgdGhl
biB0aGUNCj4+IHNlY29uZCByYW5nZSBpcyBjb3ZlcmluZyBib3RoIGFsaWFzZXMuIEkgY291bGRu
J3QgZmluZCB0aGUgcmVhc29uIGZvciB0aGVzZQ0KPj4gYWxpYXNlcyBzdGFydCBhbmQgZW5kIG90
aGVyIHRoYW4gU1lTX1NDVExSX0VMMTIgYW5kIFNZU19DTlRWX0NWQUxfRUwwMiwNCj4+IHJlc3Bl
Y3RpdmVseS4NCj4gDQo+IFRoZSByZWFzb24gd2UgaGF2ZSB0d28gcmFuZ2VzIGlzIHRvIGV4cGxp
Y2l0bHkgZXhjbHVkZSB0aGUgSU1QREVGDQo+IHJhbmdlLCB3aGljaCBpcyB0cmFwcGVkIGJ5IEhD
Ul9FTDIuVElEQ1A6DQo+IA0KPiBTUl9SQU5HRV9UUkFQKHN5c19yZWcoMywgNSwgMTEsIDAsIDAp
LA0KPiAgICAgICBzeXNfcmVnKDMsIDUsIDExLCAxNSwgNyksIENHVF9IQ1JfVElEQ1ApLA0KPiAN
Cg0KT0suIEnigJltIGRyb3BwaW5nIHRoaXMgcGF0Y2ggZnJvbSB0aGUgc2VyaWVzLg0KVGhlIGN1
cnJlbnQgYXBwcm9hY2ggc2F0aXNmaWVzIHRoZSBwdXJwb3NlLg0KDQpUaGFua3MNCk1pZ3VlbA0K
DQo+IFRoYW5rcywNCj4gDQo+IE0uDQo+IA0KPiAtLSANCj4gV2l0aG91dCBkZXZpYXRpb24gZnJv
bSB0aGUgbm9ybSwgcHJvZ3Jlc3MgaXMgbm90IHBvc3NpYmxlLg0KDQoNCg==
