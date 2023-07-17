Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA3475654F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjGQNmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjGQNmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:42:47 -0400
Received: from mail1.bemta35.messagelabs.com (mail1.bemta35.messagelabs.com [67.219.250.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80791107;
        Mon, 17 Jul 2023 06:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1689601364; i=@lenovo.com;
        bh=uBZyA/cEpODlfxDwWIAgQHJIKEfpQiAlJrQmvJDhGrk=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=UMMDTJ6MDUangNTbSDRDG/bfTyn61K+96VweuHAjaVn8OuFEJgozfqqFod4ObEO2d
         dfgBbaqFFKUFSB9eEh9wNjj1hs8E7T61HVzKpTg4IfflscTsmEyAyblvp1mByuEREr
         FFqZo3B26+5ImWAZoXY26IvGYyrQ0n0nOe/ckTLGdPtW8qaOhW2APBbJba7ym1Lmx3
         YKoY2AyVNd0GNqxcyFQzH/RmktlEw4wInMHvkznsF3PXSYFqeCXlLGoqnBBVw9XRKA
         AivuJh7hmi3OJoSYz95XEFcVV8ZktoHoUTExz0Fj3nh8gc1M2nMmIxp58l/4023tfp
         UBayZVMrU5rKg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBJsWRWlGSWpSXmKPExsWSoS+lrRvsujX
  F4ESvtMWb49OZLC7vmsNm0dp2kdniwNRpzBbTf/WwWqze84LZgc1j06pONo/3+66yeXzeJOex
  4VMHcwBLFGtmXlJ+RQJrxqZzrAVdHBU/GhcyNjDeZ+ti5OJgFFjKLNH3eBUThLOIVeLD54nME
  E47k8Tlvy1gjpDAYiaJ/cd+MUI4O5kkzt3YCtYjIXCcUaL70DomiEwno8SPV6dYIJyJTBKb9u
  9lh3CeMEqsm/4HasAjRomt/64BlXFy8ArYSvw8fJ8dxGYRUJVY1PqCFSIuKHFy5hOwGlGBKIm
  mxkNAcQ4OYYFwiWUv3EDCzALiEreezAdbLSKwiVFi8fUrrBAJBYkDZ44xgdhCAiYS365DzGQT
  0JbYsuUXG4jNKWAq0fX0JiNEvYXE4jcH2SFseYntb+cwQ/QqS/zqPw9mSwDN7O/4D2UnSDRPO
  coIYUtKXLt5gR3ClpU4enYOC4TtKLH07Q4o21dixfJLUL1yEqd6zzFB2PISOzfeZpnAqDMLyc
  uzkPw2C8l5s5Cct4CRZRWjWXFqUVlqka6RkV5SUWZ6RkluYmaOXmKVbqJeabFueWpxia6RXmJ
  5sV5qcbFecWVuck6KXl5qySZGYMJKKUoU3sF4oeuf3iFGSQ4mJVHeDVKbU4T4kvJTKjMSizPi
  i0pzUosPMcpwcChJ8EY7bU0REixKTU+tSMvMASZPmLQEB4+SCO9PkDRvcUFibnFmOkTqFKMlx
  5Vte/cyc1xbv2AfM8eKJVMPMgux5OXnpUqJ8y61BGoQAGnIKM2DGwdL8JcYZaWEeRkZGBiEeA
  pSi3IzS1DlXzGKczAqCfO6OwNN4cnMK4Hb+groICagg1xCN4McVJKIkJJqYFI3OR6gJlRznmP
  N+eK6g3+/fHzPWh0y7+HneOvJPI/ankVt5tM+3Tt1tXzxYZPDB3f7VjhN+T3ljIXADYPz2hPu
  dE7h03N2eMbmeVChnS3+uvSB/l3sZfXnK6d/1jje+8golHX15KJeFyFF0UaT3M7lZ3hmpJlKe
  euLJZe9Ejsz+3bNukuhB3Su/d3ok9tYtPiV/Lfj72K2KmREGN+eErAn0Z/XeNdqcbt3W+0786
  qMF0qlvb3XzNLi7SBXdcPe8l25k9Fel9nJu4pPFC7+p6asuyS98NwlhQSjqQd08mafnbRZJnb
  5b+acozcCA3cY3jin3DdLY30Vb2xS2vW7/mwH5MIVcn7Pkz2xpfq8iRJLcUaioRZzUXEiABpU
  N0prBAAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-19.tower-636.messagelabs.com!1689601362!22445!1
X-Originating-IP: [104.47.26.43]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.105.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16362 invoked from network); 17 Jul 2023 13:42:43 -0000
Received: from mail-psaapc01lp2043.outbound.protection.outlook.com (HELO APC01-PSA-obe.outbound.protection.outlook.com) (104.47.26.43)
  by server-19.tower-636.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 17 Jul 2023 13:42:43 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLBPr4ZworE9VF6iMrtQOVdWLazhIA0g0kKejqKGxoWvDOB0EEBn3DmCjzDd5tiVRrDOz48RxVaY1ON/IJx3WjhVoDFqOSE6fawIDLQmI6tz1NzjG84fBuJnZc4puk57k/axDiy0Q0G5lpyKFAQjpZVr/to3uirJUSpqpylcZECB85t86zRPIvVCqgajXgcnmFEKpoftnb3KZ1MlF7dpijMC4DpI+PYzFO/79F//0DtQKy6zHXdfwUJrL57xJwt8sG3/om0TTMza1gGuBESmpsqwn65MdmKrVdkIyBkP5o9qMUFlyUXBciThjz1bl/9ub4KZ/HQBdIKzv3GiekSPqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBZyA/cEpODlfxDwWIAgQHJIKEfpQiAlJrQmvJDhGrk=;
 b=VU+sP1jh6N+EN+xlVxjS1lej2ot6EsjhJOJntv6pTUsW/mXwhtKJcmG3Nt9clAEOo7e+/S3QuYmCsi2OZndHkPolX7PS8xYaFZnjZR8HEoWjqzV3g/UVSxcZQP192mJGovd8Y5RdZ1LkcYxC/WlAHHUFL58warOXFsiu8sTmkmbw6LcELQEmnwM+A5rlF8fN9PKDoH895o6D/WlOS5iqMM9I7U8/fVCaqm5jDumzz+DP4Ug7mnBoPv58874qCZX5bIs9H/IelzcRnuTvUI1+tLX0+1pRDuqgmIhHEhd1Pl1twG1aG9n7hduL4cQKuWDoWRYpQP7JVPRljnxDMnpxZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.7) smtp.rcpttodomain=vivo.com smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from PU1PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::32) by KL1PR03MB5947.apcprd03.prod.outlook.com
 (2603:1096:820:88::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 13:42:41 +0000
Received: from HK2PEPF00006FB5.apcprd02.prod.outlook.com
 (2603:1096:803:15:cafe::24) by PU1PR01CA0020.outlook.office365.com
 (2603:1096:803:15::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32 via Frontend
 Transport; Mon, 17 Jul 2023 13:42:40 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.7) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.7 as permitted sender)
Received: from mail.lenovo.com (104.232.225.7) by
 HK2PEPF00006FB5.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.23 via Frontend Transport; Mon, 17 Jul 2023 13:42:39 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.27; Mon, 17 Jul
 2023 09:42:37 -0400
Received: from [10.46.209.55] (10.46.209.55) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.27; Mon, 17 Jul
 2023 09:42:37 -0400
Message-ID: <9f0dae3b-c964-b100-c2cf-25eced14e207@lenovo.com>
Date:   Mon, 17 Jul 2023 09:42:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [External] [PATCH v1] platform: x86: Use kfree_sensitive instead
 of kfree
Content-Language: en-US
To:     Wang Ming <machel@vivo.com>, Hans de Goede <hdegoede@redhat.com>,
        "Mark Gross" <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <opensource.kernel@vivo.com>
References: <20230717101114.18966-1-machel@vivo.com>
From:   Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <20230717101114.18966-1-machel@vivo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.46.209.55]
X-ClientProxiedBy: reswpmail01.lenovo.com (10.62.32.20) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB5:EE_|KL1PR03MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d2e086-4c89-47ec-6c26-08db86cbb0ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aO8T/v1z6Ts7ZmoNBexspolK+3tBvi7EEI6/ULUFthErnYu/yOqwpf4GWmZulrjBoTKlEMPv37wNd/B4ZvDzt9IR2i+ek2jLyPEY/VH0xZtMDuS1W/hkMv9/wLJ1HiPgMtFD1bezVXweYICro+UpbbMmopmGRzVlcOjDDdmG2OSgoc3wRSb8af3f0F8NKCJtvw/26Shn1SpanUZNx95JLVx8EAamTKZYOnt+t+a2WbsLD7ivKuBTieT4pUV5Lb+TOaeQYoevNJ8BQ12OzJGkHrMdKWXAMHaWoxm6s5T6kU+GCs/WkeLXm7a57Vvs/mWKNwfJm0uqVP2CWZXp87NSu6+668/Aj7rLysR0PYkeOT0GB347f9QyA1PcVkkzgECMybPrFjqDjKk+zp9VNnSx1JCIligbngbgVICuidjLAigdMWGR35qpUxZ7vbFibRw68gwzjLSlfPNT6gXgPWEvjE+KAn/soT0Uyc8EKYyYINxz51A6hQGewlTImr7ROVo6KHMFX4h+cY7K2gSeUrR8W2ex83HgaxeCFo9Pr71wRPK6IcYMFky5MzUztTxS0Cunt1lNCtSC572uhnWDQQYzn2TIrwoXwyOrCMemRDqwSY9oKuy673AOAmT0kweZcTW73O6avHnmo6azxovciELcYe/+3g0AtMf5rM1NmEkFZ6Fy1dgwnJuzS3NKYA1IHu0MOJ5GArHW7kTbxLxWi1kYuzb5b9iZ24lpwzE0oVEl86QGiXv0f1CdxFZx5asMCXCfnXhwOx+w+LdBarTI70Ih/NdFRn7V75OFjPjKRlM8tB5AM8miLIoG4qCLXaDBZUQHx7yN4Hl9gtPWa+kpTyyKFjMBrekVxCYpT57x3VpfiRb9sGNPJnwDdJQ/ssZiTW1fjB0Yhyp8S9ZIZ9uq/pnhdxkNnAMpFU1idRotgBLAwF0=
X-Forefront-Antispam-Report: CIP:104.232.225.7;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(40460700003)(53546011)(26005)(36756003)(36860700001)(34020700004)(47076005)(2616005)(336012)(426003)(83380400001)(31696002)(86362001)(82960400001)(81166007)(82740400003)(16526019)(186003)(356005)(8676002)(8936002)(4744005)(2906002)(41300700001)(40480700001)(478600001)(4326008)(316002)(5660300002)(70586007)(70206006)(16576012)(110136005)(31686004)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 13:42:39.8851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d2e086-4c89-47ec-6c26-08db86cbb0ad
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.7];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5947
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 06:11, Wang Ming wrote:
> key might contain private part of the key, so better use
> kfree_sensitive to free it.
>
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>   drivers/platform/x86/think-lmi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 52d1ce8dfe44..79346881cadb 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -719,12 +719,12 @@ static ssize_t cert_to_password_store(struct kobject *kobj,
>   	/* Format: 'Password,Signature' */
>   	auth_str = kasprintf(GFP_KERNEL, "%s,%s", passwd, setting->signature);
>   	if (!auth_str) {
> -		kfree(passwd);
> +		kfree_sensitive(passwd);
>   		return -ENOMEM;
>   	}
>   	ret = tlmi_simple_call(LENOVO_CERT_TO_PASSWORD_GUID, auth_str);
>   	kfree(auth_str);
> -	kfree(passwd);
> +	kfree_sensitive(passwd);
>   
>   	return ret ?: count;
>   }

I wasn't aware of kfree_sensitive - looks good to me!

Thank you

Mark

