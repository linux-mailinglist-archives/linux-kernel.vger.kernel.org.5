Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310EE7AD9A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjIYOAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjIYOAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:00:17 -0400
Received: from mail1.bemta35.messagelabs.com (mail1.bemta35.messagelabs.com [67.219.250.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622E4C0;
        Mon, 25 Sep 2023 07:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1695650409; i=@lenovo.com;
        bh=0xAZ1WmHPNlstlmyvbBXYBP1Z+DX1mLRJc3UQo7gdWA=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=0CoF45QIEc0JhtB5iY25hnhFNqpub8HI15TI7fHm1anjdbkBwn2g/sn4thO2qaFu6
         GDsU5CA+v5KOXdmFqZ7dWPTeIWv7JnqIK+p1a3snN6/5ErVdPDNaV3th516RNFuHCV
         0HyXkOFzEOWzCvMSfkvl78llo3xRKB0ENZ/iHhoRM4IU9rc3FbZO5yHtrReTy4m9F6
         44ohXwtJjFC7Nu2wddaowtY62ECdIHnHunr9DJH0/u6PJ7pZlS9QioFAKlnhcyZfEV
         9VOKz9F1WSU2Hie6ftgh+kGnHfw5/wHmQK1ECXosEvjINmXO25TjdYKOHINixd4ap3
         +cRrTsCY4cIAw==
X-Brightmail-Tracker: H4sIAAAAAAAAA1VSbUxTZxjlvff2chHa3LYyXuuUrMY/QjsFo/0
  xFue+mhGjsixhZNm42AutaUtzb6vVPyM60YLKh0OwdmOzUbSMwWpRoNRCE2C0sjbKVKoL+2g2
  0ilOibMQwtb2Vsb+nfOc5znPed68BCoK4RKCNhtpRk9ppfgqTP2qZItM0yykN3vDmYqHY62Iw
  tJ3ElPcHrDhiqGWs6iic3AGVTT9McTbgSv/evKx0umw4Movx/cqH9/4EVfOOdfv4ZXxNPqKan
  M5Tx067+IZ/hSbp61PQQ0YJevAKgKQF1H4pP0kzpELPOibd6fIMQS6bz7iJYiItCGw81YY44g
  Lgd3+B+l1IIOA5BiA9Y53OcECoLs3hnPkDAKDTn9qJAJgw7NOsExm28K8xDyfLIILY1MggTFy
  I+yr8+BcXQjHz0WwBM4my+DdubvJupgshrOTgWQdJXNgONKOJPBqMhf2OJ4lF6DkeQB7L59IN
  onIQtjadj25ACfzoMu1kDTKILfChnFLykgB7Q+H0zmcC68/sqHc7Aa40BBEuUNfgVdrlxAOl8
  Ojn48ADq+Bd6ZCqcdYB0cmbBiH34AX66/gHN4Fp75x8Ti8HvpP/ZDyyYX9393HGkG+dcXN1hW
  3WVfEs66I9xXAHGAbSzMHaEZWUCCvYDRVaqOO0mjl1GEZJTexsoM0a5QVyKmDrJxmWTl7SLdP
  q5LraaMTxD+XiqHEfSBUtyT3gTUEIs3mx/QCWiSoqFYdUlOs+hPGpKVZH3iZIKSQbz4tpEVCh
  q6izZUabfyLvpAhkSVdzXfXx2U+a6B0rKaKk/xARkxe83hQEaav1tOSHP5kY7yJTDSpTfplix
  cf/RZYJxHzQVpamijLQDM6jfH/ehTkEEAq5n+UcMnS6I3Lm6LxEEg8xDslgkQII/WfJKlBwOj
  RzJ/7g0V5MdfX+2qAuvXeTsO3C0eyqfGwvTQc2F0bImcNPYslEW/e0sQ2tzASrbR5d47uL87f
  Gmk4Laj3BfyXOnyC/T3Pq7CmoCLCKt78FR0Mzytb5vTq3WWbt3stw2vtH16Lbe+Pfj+tGrUOP
  T0DB9qnm4MZ0ccXJKbAqcWOPW3Z7w820sNNyEtdNwsKPd35E8UqnfPejauvNX02YD8b+OL2cM
  fh8mO5XZ9SB07U2r3Wv8+5CpsnFp8XdrUcwX//hfmtq9o71VmycWaudMTwdlFoU+9Sz8yVO8X
  /PLh0//WS46Yde9NLY8ffW1s52zLf/YHLYfXkNM//9BaaKZdirJrasgllWOpf/aI4e2MEAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-17.tower-655.messagelabs.com!1695650407!8968!1
X-Originating-IP: [104.47.26.49]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.107.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8863 invoked from network); 25 Sep 2023 14:00:09 -0000
Received: from mail-psaapc01lp2049.outbound.protection.outlook.com (HELO APC01-PSA-obe.outbound.protection.outlook.com) (104.47.26.49)
  by server-17.tower-655.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Sep 2023 14:00:09 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbLEtBAskS+79T3UeUrerEJ6dOH1LdOt0KzbfPeI2irNKEKoBQdGpEE6J+Lftp2KWTLrYoXogZS48OqIqLPu9Pr9LdhkWeoi36qiUV94MrHwO3qwB1FElTalEyFzgx6bwxRUdQoKkZqdMkjPFfKY4U8DyJoPQrupQ0krqsuf6riC6xw0Vk+mKpmrDXRDUHautbP2uJWl2t8xJgtfPmsgcouBiFZZpLfzcFdfYoL7HRLyLJ8blukccl9HVvaIJEw9+uVnuUTekDjcNi2MsO8HyBOZX6hh9eAHjx8BxjGPVKJEYS6c6vkTiJ2OlgTFXqdQBIrgyrc0gT1ZJkaSvBRBrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xAZ1WmHPNlstlmyvbBXYBP1Z+DX1mLRJc3UQo7gdWA=;
 b=kYUPvkBjc+FEOszeXKUbLvMU1oMFkcf3bc/eUVqwRgWTa+vppg7iOivKPcfgNdfL7uPDLlE3ZAfvSfLAVZf79bm+FWPec8hNLy7w1u0wELUk9XKBF2uDf7LuKyzCqo7g6CsxPU6hUHwD/TyEG3E0sa9Bwt4qtZwITfNvvccfwUUX92c2/9cuPyzfZoGgQZ3QjVp4j9f3Pq76CLQ7hQkt6jBUdYXaBxqOWvDqgEgXB60N8SczFBt14mxVW69oRkESQ4PopyThGjPEzCTy65D17gpzmyTavvwvJyLUw1qnyLpX+PYgKEe7xUQV0+6Iwy2VM0SGpdzoK2Av9tCuMRcSQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.6) smtp.rcpttodomain=gmx.de smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from SG2PR06CA0249.apcprd06.prod.outlook.com (2603:1096:4:ac::33) by
 KL1PR03MB6976.apcprd03.prod.outlook.com (2603:1096:820:b2::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Mon, 25 Sep 2023 14:00:06 +0000
Received: from SG1PEPF000082E7.apcprd02.prod.outlook.com
 (2603:1096:4:ac:cafe::4) by SG2PR06CA0249.outlook.office365.com
 (2603:1096:4:ac::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Mon, 25 Sep 2023 14:00:06 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.6) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.6 as permitted sender)
Received: from mail.lenovo.com (104.232.225.6) by
 SG1PEPF000082E7.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 14:00:05 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.32; Mon, 25 Sep
 2023 10:00:03 -0400
Received: from [10.46.192.231] (10.46.192.231) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.32; Mon, 25 Sep
 2023 10:00:03 -0400
Message-ID: <8e1592dd-7e95-20a6-15e7-f21798af3d37@lenovo.com>
Date:   Mon, 25 Sep 2023 10:00:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [External] [PATCH] platform/x86: think-lmi: Fix reference leak
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>
CC:     <hdegoede@redhat.com>, <markgross@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230923204154.86815-1-W_Armin@gmx.de>
From:   Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <20230923204154.86815-1-W_Armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.46.192.231]
X-ClientProxiedBy: reswpmail01.lenovo.com (10.62.32.20) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E7:EE_|KL1PR03MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c528b2-eab0-4f4a-bb73-08dbbdcfb917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SkVnQrA1DIcgwXghqhezXgllWH4fGIxRcVrgCYXv3rBR3763XQNs5c+t5lFb8HPLt6IMATFS4mMRmSIefnUG+WDHGPKg07VUsL09CHtrSIiOiRdvX6LTJiTbH+rhyf0YrPGkuRgC2mPqZS1wWukTfa8pBvR/dg9FMhl5RBc2/TDjzSfXNinl5pPRt3o1TAoff5J46PKjpwPIGaxjCE/DYHMuafCfJ+nTAQu8gtj2ENgmXNltpGcKQNXFmeBkk8OWgDTGVkEQM9TWkRFOrPg2wwXnjFHQrDDi2sgBD0Pr0gWmYSFrETZ411Qn/iVnsz6YtIV5dsXqbYHCyoxmhyVgaVC1PhM9a80my55qt5Pn3lJoL4bIsr0PQGr3YfNLKIsKCNDOd+ZAjTB8+tGy9aahnCT8kx3jHb73S6K/LzVraQTS1DT0ReLJYiLw7MOFiTfCmIKVCc2hRtbjpOuWgi5KAKAnz09VySIWR+FjXKHoBBKUfbikdGppXy14vT6fLx19wJ5QQPDHyJXcRe+dBQhZEs/FU3tiB86pzvRseEihQe80JGeLUQ//jJKVoeo7iLsV4El5CdwM4XtPhe5DTnTo1G6XGNnu0q8PcYZpcK6VMpIP5rYdTaN1u0ZMwxshvC9VmgX6WxT4IfD51ATvfhQ/Od+tnTJKRqsbDT8xxyg6lK2ORYkE8g+NB/X6GIfwBtU8fnEyuPnlTWeZL6MfgIYndSMaeBjkPMHm+Kw2fRmIGORzmWwgaTwy+9BSrb+DR6G/U6KrSiPwk99+YTT1IhQgABq7LyRDSaJk5W3YNqyB40qGsM+jofTS/lz0HQgcNhDQuxWTlwBxuM5s5D6+V/61ZmKiW9JLpXi8u00eouhANZMJw3eg6d2D48goakB4qgSz
X-Forefront-Antispam-Report: CIP:104.232.225.6;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799009)(82310400011)(186009)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(2906002)(478600001)(47076005)(36756003)(26005)(16526019)(426003)(336012)(82740400003)(86362001)(82960400001)(83380400001)(53546011)(356005)(81166007)(2616005)(31696002)(40480700001)(8936002)(36860700001)(41300700001)(8676002)(4326008)(16576012)(316002)(5660300002)(31686004)(70206006)(70586007)(6916009)(54906003)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 14:00:05.9121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c528b2-eab0-4f4a-bb73-08dbbdcfb917
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.6];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6976
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Armin,

On 9/23/23 16:41, Armin Wolf wrote:
> If a duplicate attribute is found using kset_find_obj(), a reference
> to that attribute is returned which needs to be disposed accordingly
> using kobject_put(). Move the setting name validation into a separate
> function to allow for this change without having to duplicate the
> cleanup code for this setting.
> As a side note, a very similar bug was fixed in
> commit 7295a996fdab ("platform/x86: dell-sysman: Fix reference leak"),
> so it seems that the bug was copied from that driver.
>
> Compile-tested only.
>
> Fixes: 1bcad8e510b2 ("platform/x86: think-lmi: Fix issues with duplicate attributes")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>   drivers/platform/x86/think-lmi.c | 24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 4be6f28d4600..3a396b763c49 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -1344,6 +1344,24 @@ static void tlmi_release_attr(void)
>   	kset_unregister(tlmi_priv.authentication_kset);
>   }
>
> +static int tlmi_validate_setting_name(struct kset *attribute_kset, char *name)
> +{
> +	struct kobject *duplicate;
> +
> +	if (!strcmp(name, "Reserved"))
> +		return -EINVAL;
> +
> +	duplicate = kset_find_obj(attribute_kset, name);
> +	if (duplicate) {
> +		pr_debug("Duplicate attribute name found - %s\n", name);
> +		/* kset_find_obj() returns a reference */
> +		kobject_put(duplicate);
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
>   static int tlmi_sysfs_init(void)
>   {
>   	int i, ret;
> @@ -1372,10 +1390,8 @@ static int tlmi_sysfs_init(void)
>   			continue;
>
>   		/* check for duplicate or reserved values */
> -		if (kset_find_obj(tlmi_priv.attribute_kset, tlmi_priv.setting[i]->display_name) ||
> -		    !strcmp(tlmi_priv.setting[i]->display_name, "Reserved")) {
> -			pr_debug("duplicate or reserved attribute name found - %s\n",
> -				tlmi_priv.setting[i]->display_name);
> +		if (tlmi_validate_setting_name(tlmi_priv.attribute_kset,
> +					       tlmi_priv.setting[i]->display_name) < 0) {
>   			kfree(tlmi_priv.setting[i]->possible_values);
>   			kfree(tlmi_priv.setting[i]);
>   			tlmi_priv.setting[i] = NULL;
> --
> 2.39.2
>

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Do you have any reports of our platforms where these are seen? If so I'd like to get it fixed in FW too (and I can get it tested on HW if that helps)

Mark

