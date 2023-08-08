Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3787A774AFA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjHHUjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbjHHUcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:32:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8106A159B1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 12:54:08 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378DAvxa007376;
        Tue, 8 Aug 2023 14:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=OPc8WNBs035rHgUD0VoTi5jzZHYIPXQGXepOJBmOoH8=;
 b=C6EXVK1nUxpWXqe8GoTjkW4+0VksSJVFSfJO0BKOnjRvzagDf9dwtDGadHplDnwKfCUo
 FCltC/ToHUbJ9qu/u+0uwk7GUPab4nWO3B0q6LmqBzAa56UC0eKIC9i49R/laWp/RQo3
 TaFdlqNiq1399po5v7sJ1rhNsGkh9FKbUAhRVVI8VUZuN6lX8V7z4sGXkS2jxIfERSLW
 KDQiX2/G4ExF6+zR5cN58DSftMUrLQuqw+V1/fNwtc9XNHLtgpQlQTSLGL4TB3kfA/Tc
 i2yFmigkUGmRzUUBAKtJL9PUWO6MWAcH6TWjWr6N6QJRng/yiX2Xkhv4Yle2Yuqs5rHz eQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9e1u593p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 14:29:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 378E3fEs027736;
        Tue, 8 Aug 2023 14:29:53 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv5v6c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 14:29:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/epm+8W0llc1MvgsWITCoN5OIoU3rwLctWwb+VT6uGzyeHpL38bZzRMV1oDPFXt9/VAyxBFMr54qt27yDV/ub9kMCvn3yANTfEpQBFhWqtmfdji+xuPUkCNEB/GAHAeOZcXn5LJ8jYbdrXDQW31/zKf7XtPWoPbs1k8+CNHvW52s7Qd5pfLoec4BJ05eDq/y0odnWsABp0jCvQu5ZjY9jps6ZvEHWZNaGkceUMtNH4EFOaUaHvZVmEny5o6XRSuTsGYVrWSRL6YCHFdZ4ExDPf30zE9j3FpqVvOPr1nOOd8fMm6mcGqI41JRwABvlb9p3HmVQPNFo+lYh5HCo5omg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPc8WNBs035rHgUD0VoTi5jzZHYIPXQGXepOJBmOoH8=;
 b=hjmx5eWDC4NO5zXiPiR30/SVf6+HatqtF2EH5Ka+cnSPvjt+OfKgnGNaB14YiEhRZZ31twSx+dAlsIn8T46Lvnn2/20Lsid0P1s2UI/cdQOm3+HxZaB/2zR7i23T5ivW6pezu8EMANvGyM92ZrcRbQCit6zjg/gm2TZRF7F9FW+P0l6X2fPm3XJu9VaH0bL0BmYPkFhhEPo7g/0fA6m1vcsEDFr/VP1pkOo7W4nEmaSUJDhTZyU7wQluUWo2RIgqSUucRqtMGSza6TJJ0InlsBHCszLA4U5GlanvbdnN5IRvfptXu83+Yxj+toZyIlcR8PlsLHPBnsZyhxbh6faEqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPc8WNBs035rHgUD0VoTi5jzZHYIPXQGXepOJBmOoH8=;
 b=FKcplxfzE0ngdoGDjr+ITVzZrwOzBSaG6I/3kYeLIzLVivFUfRbv6eKuZezZcuJ2T/XNsukiuJukq3R54GnexFr38whKKKf/X6TGBAsk0YHOUD3gSHHL547XyLCGhOZBzg7DONY7YnyYW0iGGU1rTxu2naw8I6NeNuaGyNgtqNc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB7051.namprd10.prod.outlook.com (2603:10b6:8:147::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Tue, 8 Aug
 2023 14:29:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 14:29:49 +0000
Date:   Tue, 8 Aug 2023 10:29:45 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC v1 4/5] maple_tree: avoid bulk alloc/free to use percpu
 array more
Message-ID: <20230808142945.tulcze5bjg5ciftk@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Matthew Wilcox <willy@infradead.org>
References: <20230808095342.12637-7-vbabka@suse.cz>
 <20230808095342.12637-11-vbabka@suse.cz>
 <853af8fa-0cef-b00b-3fd6-9780a2008050@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <853af8fa-0cef-b00b-3fd6-9780a2008050@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0439.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::12) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: 239449c7-6d8f-4001-2564-08db981bebf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iwz4jxB0Ym080JiZpKOaEyMTGFhyTcKqtbzYfecFuVLtspC46Gh92fJQedGkRValryzQUIc4ZeIvHNOFygWgyoU5MCs7Sqi4qe7vN4Yxz085pOWHYZvGipQ7Tr0XOVAwdX41+OWFHmkg5jAQEA1Qi1UDhS3IkgC7AizyHHgcmt+W6EAAAQW1P6PHwVMbv1Rk1a2cg5b2jKr8LoYfS2Zox139Ief2Kkj19rTvDx/PS01xOfCP4EfmhgaPZjWEAYU6LIKliuxKBFum1A7WAgbiFmLd7p8VnU+qIre2QgvPOnJ252tBZxeO8rE/U3SzB/Q401Ouivj++WvYUUunWURgqqXmrlAqa6cFcIfwBqi81MaVDVY8yv2daNAdg1qy4iWsqsUKTnt5rWWGdEvEi+15jMXchYlY5QozrDmCyel+LWps7+kvLBkmaEq2vhgYMYgITLbgVAy56XElhJtGteDnV70hYAmWdVApf62GBESOow2YhQkNK37zIqK8kdUy2CmA9UoDatF7vNagUx+BF4RFGOtr0yzHLjBaDxsQQjTExL2Xb2b7mD8mrd+3yxjf9z2V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199021)(1800799003)(186006)(41300700001)(8936002)(8676002)(83380400001)(6506007)(26005)(1076003)(86362001)(33716001)(6666004)(6916009)(316002)(6512007)(6486002)(478600001)(9686003)(66476007)(4326008)(54906003)(66556008)(38100700002)(2906002)(5660300002)(66946007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWszdU1JaVFSZUdSdFFxS0Y5UStlOEtJNVdjWGNVUzRyNDdnMGo3dlpkN3hr?=
 =?utf-8?B?RGY1UkNNQlJKNGFHenQvMlRFVDdJQThMT1VjRmFzeDQwdGk0V2V2VzBESnF0?=
 =?utf-8?B?aUtnT3VNbjFCM3Y4TlF6OTg2SWJmcytKMllrbUYyWkdkRVB6NnVFdWhPVklJ?=
 =?utf-8?B?YVZQRG5lcitOb2Vsc3E5WGhONVZ2QkI5WkdRZEhlcjVRdWE0c2tmSW5SeFRs?=
 =?utf-8?B?bVlCR3l2Y2YycVNMejFKdEduQmtETWlmWlRWcURNdEh0bWd1dTNqMFZXMEEr?=
 =?utf-8?B?VzkyS08rVkdoUXBXYVYyYU1NU1N6aVdDVHhLd1lMRytKZWtRbFRCVHhqYTRt?=
 =?utf-8?B?USt4ckJFSmdaY3NaZHg1eTk2K1NJemU0U2hIMFVzQ3VJdlVDTHM1cVRBTWJa?=
 =?utf-8?B?bG04eWVKYmNGa1JScVRpWExyN29nWWFQVGlLemQ4eUFQTHAyNEJrSFl1YlVz?=
 =?utf-8?B?WFJla2RHK2Y1ejRYQmlQTmlXdGtZQXNsTlpjVVFzdEx1WlVleXFhMSs0NVNy?=
 =?utf-8?B?ckhVWFoyYTFBbnN2cmxOU1IwU0ltdlVTcWxBOGV1UDRoNktCSS9Wc29MWTJS?=
 =?utf-8?B?V05CckNQdkJyKzRnNkZQQ3R4RXFZVmdGK2lFRENjajVGODdZWGl2SUZ3RytZ?=
 =?utf-8?B?Q1IvSVU0eHlzc0lzTVVTUHpmSko1RC9ET0xVamc4WmI3dTlaeUZ0eExWSGJG?=
 =?utf-8?B?V3RlYm01L3dIeWZpY0pwMlVsQmY5Z0p3N3RJNm1CZWNwNlhYM1Bpb2JDMzNS?=
 =?utf-8?B?eUdoM1QvSVdJSW1oaCs3bGRlN2J3ZWpGZUlwV3I3K2JRTUJnRzJwQ1krUWZm?=
 =?utf-8?B?OFFLQUh5S2cyTWNnWTBPMDZFbldLZFpxenJROHVCNk9qTWpGc2lBclJMeTZr?=
 =?utf-8?B?aFZaREZZc2hHbHp0blpNQVdIWUxBUXp0RnpjeitzM2xVS1FMQ1pWQXRDNVVt?=
 =?utf-8?B?OEc2ejA2ZlhBM0xRb2pkelB1Mmw1ejBHR0IvTXZwMUYxUEZZdWtudjQ5MmNh?=
 =?utf-8?B?QmJkRlprMklQSVdCQ21ZNllOdHRVOVdFdE5NOStLVHh3L1JEcUxYWTJqWng4?=
 =?utf-8?B?Rzl6UmRzWEI2VkVXZ1cyUE1Da0gydTFWcnlvOEVEcnl2MUNma0ZXQXJJL0xD?=
 =?utf-8?B?ZERNZmF0RDJGbmNPMkVXbzJ5YjRVTW1FWGxMSnQxY09wOXFDYzZUSE00eE1B?=
 =?utf-8?B?MnpCOWZPbEo2ZmMvNFordStwSFhvZnNzVnhlL2dTN3ZpdCtteWpieEFuNTds?=
 =?utf-8?B?bzRXNzRJUkthcTBqSEVtZm9qb0JaRHZubWR5NVFGeUxIVlJGWVNKSGsxS1pK?=
 =?utf-8?B?czB5YnRFS1IwVFRlR2hoYTIvYTExWGhrdnM2YU1TZFdNaklGUUlQOCtMNGx0?=
 =?utf-8?B?R3FIaWEwR0lTWHlKTFBvSEVtcm1FT3pJUE9kVmVpWnJ1MDhKbkxzSGdiWlJ3?=
 =?utf-8?B?NlhtTDlCU0ZQczZTZUNHMlgwWHZSbjduMXZGNGhUcWRlVU96bGYxUmdRWEhY?=
 =?utf-8?B?RFBQL0lIenhKS3F4SkRiRXB4cjN1QmdZY1BHamJudVpja0xsMXFJRmFtRUJ2?=
 =?utf-8?B?MlluY09jUjU3ZUF3bkpMSzlxK0Zjd2c5YWUvSEhmZTVHSktGMUJLU0ZtaUVH?=
 =?utf-8?B?OXMzUHpSbUl6K0pkVkliRUNqM3hMZThtQjM3NFZxK2F4aWFiNlFjTkdaalQ3?=
 =?utf-8?B?ZmR6RG8xMVQzSTR5YXFEQmQyQ2U5MnBVaFd6YzVYNytBUHhRNFRiVEtDaXRs?=
 =?utf-8?B?TDI4NDBqeGViK1BURXcvOGtiZzlTUFpzY3l4SFg0OCtCbTZ0TmJBQXNFaDJy?=
 =?utf-8?B?d3pabmR2aUJMNHpRQk5vajJWSEh2WUkyaW9aOEttK1h4OExYekFWL296ancz?=
 =?utf-8?B?RmFvWVRZa2JVdC82M0hPWnROcVN6SzU0ZHdacy9IbW51dDlwS04vSnBRZ2d3?=
 =?utf-8?B?WlA5VWlDcVZ6QlVHSmxKMUNnTXpaL0c4YnBITnpjSFptK3pKQjVqb1JMUkZ6?=
 =?utf-8?B?ODh0SDl1RlYxNkNtUHhCOUY4LzJmVVJncmxNa2dodFAxTlJFTjdmalpGLytS?=
 =?utf-8?B?OHdET05sQklpZVVCN285SlROWTBGakIvbGNSTzdxYXVsVFpHMkdtSHk1UUJS?=
 =?utf-8?B?S3REakxzWjNiRHYzOWdPV2FiTXd4YTMxRnpjeEtualljR1BoWEN3MVE3dmFs?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?R0Q5bFpuS2NqOHBySVQyNGJPUE5MTmZHMlFJcXFTeTZ6NHhrYmVQTUNBWkky?=
 =?utf-8?B?azhYNjNRRVloR0V0N2IyVE5MNnBPY0IwTDVubXN5eG5PTE5tcHNmdzZ0anJ6?=
 =?utf-8?B?OTdYTFdNYjk0a2JYbG8xMUM5QXljelJUOUlUMzMvRUt3WC9NaVNPcGd6WTFG?=
 =?utf-8?B?SW9OMGQzUUovU0VLQ2VpUCt3WUhmQXJNY3ZQWTQ3QnFpYVpoU0lqZm8wYTRN?=
 =?utf-8?B?b2JXYnNTdFAwQzVHRE0wK3JLUUNXa2xqY3BmaVJGbXJpekhXS2E0YUM0WGN5?=
 =?utf-8?B?dU5YS0tnaTVtYVBha0xJTHdwK0daeCt2UzA4d0VKUDBwcEZrTFUvamtFcXEw?=
 =?utf-8?B?R1IxemJIREMxZzh3cTBJMnJNeThkbko4aTFESFRDUG5ZVlhpSnJLTkZkUXZG?=
 =?utf-8?B?eWRxdlFJaFZocnZuZDk2ZGZ1UjJiM0lOTUVGeDZXL0tvRkVsZnZTM3JUalZY?=
 =?utf-8?B?OGNnbVR5SGVhN1pMMWJmYm1TS3lFZENPRkduMEJhS3Y1UnZjRndyTUNONXRa?=
 =?utf-8?B?OTh2N3JlTm54ZGFxWWdvVExsU0J0Z1hnT3JUQTFudkdXa0lYY0lhcjVQdG5U?=
 =?utf-8?B?ZVhQODB4QSt4SFRENlBTRjFPNk4rUHJaWmV6c3R2MkxQbXBNOXFiZlNUOGZ4?=
 =?utf-8?B?SE9lczE1QnZuZ2pKOEtUUm1SZDlTL2pnOERrZW8zVUlZQ1g5aEhqa2pYNmdn?=
 =?utf-8?B?dTNwRStLSmFUSGxhdXNIR29OaytaUzRiNGFMZlVoektVc3VrSGNWelQ1OFZ6?=
 =?utf-8?B?dEdSWWxXc1ZKKzFFWVlMRm02VVdTR1pOSHlhaC9ReG9kNnh2cFpWK2pVNnl1?=
 =?utf-8?B?RXlRTmUxUFppeFhsK1dNUDd2cGtwRjdGOGZudDIvZVNCajJiTTQrYThYS2VP?=
 =?utf-8?B?ZCt3U2VpQkZUNjYxZmhuK1BieWZueEFheDNNNHFBQjlUOS91aVdINHo5V0RD?=
 =?utf-8?B?SFdGWFMzVU92WCt4Ymh6blZwenVObnJlUEJMNTdtRHVVakRrMWZXZXNvTGls?=
 =?utf-8?B?VzJXSXVnWUhqS0ZnOVgydWtvc1JyTkg3QWVYaHJHMVd5c3NWZzVpdWQwcjU4?=
 =?utf-8?B?NHRYanFjb0VVSlpjdnlqQW42Zmk5U0RXdkJpVDFWWEVGRWsyMHNMcGtSSzlQ?=
 =?utf-8?B?akFYUVpWR3Y2WXNNckxIUXpiRUc2N2IzVUdNUDczREdyWDRxaWxCeldiOHJN?=
 =?utf-8?B?bFMzRkpaQlJDNXlxWWE4WTBHMjRCUmkyeHdVelVSa1RTbmR4SUp2MkNiM0hT?=
 =?utf-8?B?ZHlVR25NSVZDbUlvWVMxOU9PY1RETkJDandPSURtOFArL3IrTDE5NVM0Ums2?=
 =?utf-8?B?azVMU1VFd3BYNEx1Yi9heHJyQ3VONlFMT2w1NWhtRUhGNW1JTGxMRkJGUklp?=
 =?utf-8?B?dkRTd2UwS2tqZ1pqa2FIdTBuOU5ET3JuNks3dWhFNCtrQVlSU2Uwa2JiWHov?=
 =?utf-8?B?TVBTQzIrMFhIbUd5NXVnYzJES056L1R2ZVFEbkVBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239449c7-6d8f-4001-2564-08db981bebf6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:29:49.5031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/hhpJ/O0P8Joh4a5qNqyBf/Wstv43jtLllbFscY/oOgKWtbbQb/jI26qjZyB1StCDBQ9+fSi+tsicbsKNFvKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7051
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_12,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080130
X-Proofpoint-GUID: u8KD0DjoG1lnaRxt9Z3jYmWBMfeiUlNk
X-Proofpoint-ORIG-GUID: u8KD0DjoG1lnaRxt9Z3jYmWBMfeiUlNk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230808 07:17]:
>=20
>=20
> =E5=9C=A8 2023/8/8 17:53, Vlastimil Babka =E5=86=99=E9=81=93:
> > Using bulk alloc/free on a cache with percpu array should not be
> > necessary and the bulk alloc actually bypasses the array (the prefill
> > functionality currently relies on this).
> >=20
> > The simplest change is just to convert the respective maple tree
> > wrappers to do a loop of normal alloc/free.
> > ---
> >   lib/maple_tree.c | 11 +++++++++--
> >   1 file changed, 9 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index 1196d0a17f03..7a8e7c467d7c 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -161,12 +161,19 @@ static inline struct maple_node *mt_alloc_one(gfp=
_t gfp)
> >   static inline int mt_alloc_bulk(gfp_t gfp, size_t size, void **nodes)
> >   {
> > -	return kmem_cache_alloc_bulk(maple_node_cache, gfp, size, nodes);
> > +	int allocated =3D 0;
> > +	for (size_t i =3D 0; i < size; i++) {
> > +		nodes[i] =3D kmem_cache_alloc(maple_node_cache, gfp);
> > +		if (nodes[i])
> If the i-th allocation fails, node[i] will be NULL. This is wrong. We'd
> better guarantee that mt_alloc_bulk() allocates completely successfully,
> or returns 0. The following cases are not allowed:
> nodes: [addr1][addr2][NULL][addr3].

Thanks for pointing this out Peng.

We can handle a lower number than requested being returned, but we
cannot handle the sparse data.

The kmem_cache_alloc_bulk() can return a failure today - leaving the
array to be cleaned by the caller, so if this is changed to a full
success or full fail, then we will also have to change the caller to
handle whatever state is returned if it differs from
kmem_cache_alloc_bulk().

It might be best to return the size already allocated when a failure is
encountered. This will make the caller, mas_alloc_nodes(), request more
nodes.  Only in the case of zero allocations would this be seen as an
OOM event.

Vlastimil, Is the first kmem_cache_alloc() call failing a possibility?
If so, what should be the corrective action?

> > +			allocated++;
> > +	}
> > +	return allocated;
> >   }
> >   static inline void mt_free_bulk(size_t size, void __rcu **nodes)
> >   {
> > -	kmem_cache_free_bulk(maple_node_cache, size, (void **)nodes);
> > +	for (size_t i =3D 0; i < size; i++)
> > +		kmem_cache_free(maple_node_cache, nodes[i]);
> >   }
> >   static void mt_free_rcu(struct rcu_head *head)
