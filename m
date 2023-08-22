Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BC5784663
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237445AbjHVP5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237422AbjHVP5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:57:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52722BE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:57:18 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MDKS65014772;
        Tue, 22 Aug 2023 14:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=spvJculM2kcSK0sOSJrvCAwdfDAh+peFLEVkU/tP7tA=;
 b=PuwI8G3eALPrCboeqQAwm9bq0ZMWQA9UInJVpA6ohW5QbSbbqPF8TTdLwo37Y/hv+0/P
 nklPsT1FzGg3sGf9uRHRsO5sUrFzVKbpOt0izOa0MFpdfDsSdHB2Kc7vIk2UPqc+xlIP
 ExqB3whbev9treAi8uiLmpYfz6ifVRTqnjCtWe2LtHid88SatM9v2L/w3VTJ7CMNCmo4
 iviOflkEwYkjVFv6FhhpjONLKyl2mOepn3IDQchtY0rfeGOXCwBBdVFMCaQpnRxw6Eop
 hxA+hJKZKAUxswnW2dNlIyzrmSokMiB8feMrBEcPz+olpYxVG03+819OtybpSF40HQny yQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjnma5bds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Aug 2023 14:09:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37MDXmVn025312;
        Tue, 22 Aug 2023 14:09:51 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm6be2fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Aug 2023 14:09:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpkddERe95XHHBudjY+mvm5ixiPzkvuWW0NsFLCBLc0RTscwcxS0lScVgsYaecJxaatKScQXPOBJVmNOIZu6KJcNqy0fPhqA542plyISHv12yanWrLqKhTQxPD+986VcN1X5lWXf3lrjCKwLtBbVRSWNYAS/iMLEgmYq1fhyEyQFN3Cv0pOltMYe8grSK6k7UMy9e/rqjFjmkk/b3LBiWK62XgpL9vkhLLTunMXo2r5ybHTKFfpMgIVDcj0LvyYQbbNgcandZMDpLw2CtPLS8JMuBfmT5ZLb2Kpr55LdBp4e+4nIT6kgcfKNGiT0Wow+JAzaiVFnBxDT+x8J75ZWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spvJculM2kcSK0sOSJrvCAwdfDAh+peFLEVkU/tP7tA=;
 b=UGYa7u3iKhTrOGOdcyVZhDt9EwuDrxF8PZJRE7iyG7gLXHRALnknLOLwSkwBmDwpcG7Wj7VLeInh4Wlnh1DMbULKRRw0vYuclzfsXkOsGrgFPYAGZSKa6DQDhRjho+Kl46h3pvkbFY8FGgab0sOXyvM402014HMTVDG25Dc4OdlhWxbgzLwwOuxQReDi2c7x1Wz7m0JKeaidDDvmuT0d941W10yMWzHgFUEnK5/jehynDKm1elOJh+mr3ldOkLjU1UCleNR/dOYD3dx9Xh4U23LeOWm/EhyaRGpOA1C5GeAZWi5Gioq1mjilcHZeY03GczTdeIc9TbZlA6gwS57RnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spvJculM2kcSK0sOSJrvCAwdfDAh+peFLEVkU/tP7tA=;
 b=wR8Z0SvOgg5LlwjvaANk2OJnjKoWzeI6xrn4hbEyPIDNnuvZ0rf78aZdkVhh8csnCYZ4hHD5se/GW3l7UJlzULn34dpbVIqH+bkQJLvFdw8J6ZWLJN2veOK+e8gnN1H4OpqDY80iECa/7yOOuQsfw7nZuQ+6XU4zdUNcGfGGf1U=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by CY8PR10MB6731.namprd10.prod.outlook.com (2603:10b6:930:96::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 14:09:48 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::12d6:cce8:e298:3844]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::12d6:cce8:e298:3844%7]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 14:09:48 +0000
Date:   Tue, 22 Aug 2023 10:09:46 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH] maple_tree: shrink struct maple_tree from 24 to 16 bytes
 on LP64
Message-ID: <20230822140946.kbmv43l4uhwwqwln@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Mateusz Guzik <mjguzik@gmail.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
References: <20230821225145.2169848-1-mjguzik@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821225145.2169848-1-mjguzik@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0238.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::28) To BL0PR10MB3011.namprd10.prod.outlook.com
 (2603:10b6:208:7e::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR10MB3011:EE_|CY8PR10MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: 52153943-3858-423d-7f56-08dba31971d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdOXpmCtJFRJXkEcuXZAQIlJG6OYz561Mpei8M28VImydaGY9cod964jWaoe9kL6sCWYSiz0pK3GL/cIOKDEGT35pDQkHqhkvo3G/ojFo43s/4Di67A9YbbNx8oujKzKNL+OxxGfOKQ+IPmsYGICIGH6EdqcwSBFzZcLKUcuhdx8sZeEKRiLId0b5K5SZK9i3vksvvKPOIOPlhdoIhSTGs7hOV3FkRgU2WvF70MZ23LIzxasrDalnHWf+XTe5dAnMrpWQBf63XS7sZedl17++Jv1FnoJmxwJsvnRBiWl4UKEHPjpq6hUeMNYhAzXy0lG6DC8iGYurL7AVVzUVAMn0mHO2ojbbE5k7BEd+n63BU6vYb68NoelOjyAG+PttQkWJZ15O33jT/32GsT+fqvQKvwZ2O8BIo/rXR8/MQlj0VC0HmG2pwQb2W6KK+KMHNOjQAdfq01j0tO8RQJbt94bmtgspp28sbhx1Yn/LudsQ2NIVZNKX5E6HmStReLiZDm+RT05Ovgnc3Jr4JUFPNDZU6e9FdAJvL+LZm0lClfkJ7XVvMW5eBmFeFoWzmNKyTCQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(6916009)(66476007)(66556008)(6512007)(316002)(66946007)(9686003)(8676002)(8936002)(4326008)(33716001)(41300700001)(1076003)(478600001)(38100700002)(6486002)(6506007)(83380400001)(4744005)(2906002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RGU1PWfaW27jbPh+guc3oZ8KqAX4LNt2TcJezAQBAo4gOs6pxESXwQbdBrZH?=
 =?us-ascii?Q?+zrCrabWKQ+0h0icSiIn9U0ymr/+CcpTbxAZ1fu7aoOtpNvJVMnNkecF61r6?=
 =?us-ascii?Q?BNS2G9l/GDfCUXGXgFpV5dBArI26n+daSgNv0KANSrgXhi32B112+rwQsTnO?=
 =?us-ascii?Q?42dKqtv5NcWMn3qyrjwQ5MtYENLb1NgcgSFiqyniA4JtZc441+fDhnTFOH1r?=
 =?us-ascii?Q?h5FBmb80cRgr33IP+eLU3WxXUezBGdxUoGHMvQIaH4OJpBjiaxaUyE7/HKuI?=
 =?us-ascii?Q?WHAN4TYuPXwLWvfc/E5wkpJa7oojzAABs7fn7d20HJC40AzUW4fuRIsp25AO?=
 =?us-ascii?Q?6g5axi89saORFxvURnUL4UsWAr85h8tTJRrXWquy+TWoKqPdOF+mS0kY2rR5?=
 =?us-ascii?Q?yaBNJ/sQ7poL5+QBRbfiOHx4VIvPs101WsuHbq8cZcAe8xPbecBO81aagmoZ?=
 =?us-ascii?Q?fdp2Y52mbRxIh1WkTSBuDK5kIZRJJ0Sy6704/FTJqmooBCrScR6nIFlgF4eb?=
 =?us-ascii?Q?z4t5gNWhCJRUrCcWYq9FH7dwhPUssaI2E/dw/iAGV2XFsz5ukd7o7SHXsTXp?=
 =?us-ascii?Q?u81x39r0tcQpK3JpEwSuNPoRgMuEZGqeuNJ4zveulPLkEtl2ff9xXzF/QA2q?=
 =?us-ascii?Q?M/pKODiqBhIgLhUMSPXXWx5JHv6+pkt+GiPFdzVK/K/AGNJZzNXiOFtgqHpO?=
 =?us-ascii?Q?ekpjEKmtUsTwv5gtNbnJjksG98kw7akWPpo5f/ykd8VxYu0Ac/S0mONozQ88?=
 =?us-ascii?Q?mbHPi7KCs8thCIfJeEIarwSmzUXB0nZP2X6zDQs66brMZyleI3c0DWKXqi28?=
 =?us-ascii?Q?LMcW3JdoCN2aXeYyDfE6Zg1jKSvJMPpA1aAkzFL7LsqUioThxLcAAVvaIVL+?=
 =?us-ascii?Q?B1ydsUAalmr/T+x48kRkmEXVwIrT4qKtI8+Tf7s0/AjFZYSA9ZO28ZVFyu7c?=
 =?us-ascii?Q?jyHbONa7bd/BBx1Je1qMK2ZtNYBlrIkWuEnua3o+Ba6nVPJ0edpZQJfidSQR?=
 =?us-ascii?Q?EYRY8Jj5x8pJsNoRLa/UYY292tRejoySIiIZgP2wUcPn/cY2zG4hHbpTrdnL?=
 =?us-ascii?Q?AZV7WDId/N7JeEim7JeTDSfudblUIRW8aoh2oTNStswOhBvOZa8pkMkxLhDU?=
 =?us-ascii?Q?4cgAlwBDzmq0hDE6yyseUJe4rwpLo/UzTRdFqIHoZGPVzZXdomfFeFCjOggW?=
 =?us-ascii?Q?LzvYQgC4DpaMoxbLA+fYyLQmZ1/pfY6KyUT4BtL+UysFqtgos8oISoX4+Xyk?=
 =?us-ascii?Q?4kWaTs6R7mplIEMYzfqR0tpr/nr9bLo6La2DiVfNoqzM46u8FqEpGGJ8ctQT?=
 =?us-ascii?Q?wn//2iQ84IBe8Y7QDH/LL2R7qDpEpscpy5k3kTyLxBepbGEis0WJ543tKrw0?=
 =?us-ascii?Q?e/feF4QrI5lnLGLbc7nAzZtKuCAGefbna84kHbYXm0ASgpDuIjLT8orgXcOV?=
 =?us-ascii?Q?Kzpa/dpkaU8D+MbQxcqRfFxsGJF5rt8uVkUb++K/5cTdhZc7r9/xFULmiRnY?=
 =?us-ascii?Q?Xe9Z2knbK7jWH6FCstiNG8o9Q3k5Gp0JvUdiklMfMPzBHyw6K9JZ6vzdefVb?=
 =?us-ascii?Q?qHhim24X/LyxyIppfGPj6cIv7AZ+SUt/654RJIc7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jdRdAgW7JKPrd2TqcUNuxLTLz3cUVTwC790vMxBsHldmg/6XCvab1QXb5yCLvAScMlmvtprclPXNAxzzmkZfNkkx9JTRXtyN31vQO4aTkk5cvudYaYqz7aeOEjOL35DqG7qIBO3thA0AXFfNLs+cPOP535/GAy7zpJv9K2PN4q8BdDNT8BoTIaIEVcF58gqm/0kHvwh0zHsVOlS1hFy+oMvCHZW/5tEg/r7oJaA4b/dcNDkncRGc1wPyJoHg7D/4fCmo5sPTu3+KUi+1Oy2Bp//jmlOmVbGSz83epLBpo6FBlQ7moR2/1JLiToxCvmQHZ5360YOuLD7OxCbRQqLXaLM/XSQOtn2SnMPaQ0LZocHInouWAR/Py3gMu1dgYsf0HH2vg0VlD1G8lG26rbHAS0AZLK3CHl5RC2BEQOtMG8/PCLx0bJe6zKnYItJd/uJAUB1GDc8/X1i6pn0p1FH1BqF6dHbQMDIIVtMMtMGjktH7JwzTTPdyuWMiVn0QT60MZ9r4xJ4fNszJz0jLsQ0iZOpNTT4/3UVq/Hf5TR4vrUrzv1N5lXs5T2BjO5OUQOsA0FJc4tCAN6guTarJXbOhWbx/cS5QtZ/TGDttqYoAxRHTEI9LCGXIQ5aQV98DTcr1tKbWgBH46jNuVme21/dr5b1BWTbQ/3OfIZ62Mz5JLQqQDqjo12AVR3IaUZe+5lKNU4C2yGZpudZjrdhjEWSBQlwHi4qrHKGKZMpQBDoiYhV6IWygzSjzS7weA/8NXimZS5Upshcqpxc65g2blVhxLgR9ciJ5uLaAcJxWIeLSxPEX+oL8kxSeBG6NRZMk9WkH7yrWYW7Frjjl/bP8Bcnq8+wZF4cDwPD3pL356YTujpt+CyolAoW7BOm3LOQzt3PerZnls+i4CPD13tnY68+05a38ghxdsfunGQc2EjhsQpA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52153943-3858-423d-7f56-08dba31971d6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:09:48.4399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yZdMG5/ddOAX9l8M0h32FMGVUSiQ8yHihgLaBdoBpgbDlgGFzSB/6NVv4o9G1S/qo4Kr+8zgHY3TDqk+vVGQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6731
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_13,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=848
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308220107
X-Proofpoint-ORIG-GUID: mRcy3D3b9F8rIBZJ2qScTA9c5nSCd6bW
X-Proofpoint-GUID: mRcy3D3b9F8rIBZJ2qScTA9c5nSCd6bW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mateusz Guzik <mjguzik@gmail.com> [230821 18:52]:
> by plugging a padding hole.
> 
> [sounds like an obvious thing to do, am I missing something?]

Thanks for the patch.  There is no reason for the current ordering.

I've tested both 32 and 64 bit userspace testing to double check
everything still works.

> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/maple_tree.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index 295548cca8b3..5bdd3ce34cb9 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -212,8 +212,8 @@ struct maple_tree {
>  		spinlock_t	ma_lock;
>  		lockdep_map_p	ma_external_lock;
>  	};
> -	void __rcu      *ma_root;
>  	unsigned int	ma_flags;
> +	void __rcu      *ma_root;
>  };
>  
>  /**
> -- 
> 2.39.2
> 
> 
