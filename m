Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F9D80D07B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343966AbjLKQFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344219AbjLKQFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:05:10 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA39C35AF;
        Mon, 11 Dec 2023 08:03:55 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=mPsa2aTEXy5utqfdjWFRPdqV+F2qZCTQtMQqrnazJyxydLcgH+guG5kNMty2S6zXN0A3Oz6MpYBHxfN49kg1j4nl7Ze7slaIk07dXvXeOxd1qPogTR5+1UojrlfrrELJaVzt0Heaw8kUld9CcWz8O4UhqNy6exX2b2bJtG665issJjd6momtKUpBCVPcrg0k6QHnd/BVebTfnzmbxhuwqr52LOYxBRJO7Bhi1og5AXfmIN9Zedi1Tz/z869hUnC958/jvjjedlZlSIbii66IDhniQHRlDdeoiaN3/FQOySYmR6JjyKjx90MpKzM2IaEKMGVPXio7oeXL8jkfn5hBuQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAOWK8zygrH4JJLvXwgmhu4Zcwi6QzVQhcvQcHQ3td8=;
 b=T7BdzwvonHG1jYgMA8khWREwG/7e96aDlZE78oRkgZ2k33vIrMm4DYUm76rKUbAh0Mw8U+L0bgxCfaF3U9mZlyWAp8V30EkRutMEkaOWbOIbWjia1pPs1c4+B8+Tq0gY5voLynoALnstxaF/Og77dyVZHkpCAGo2V4FnBIawcHhGMI89O6hhIfXKLxFlubFUL2muBPI1UHFu2GhRbwTWz0JXMuzgXpvbm8upiSbQZ0meup+ybTsrvICu46TsjdDMcpyaeTJwA/xxOLDq3pvYVYuU/Nn6fkbpm3dC8MzpAIVEGGq9VLXaNmRGM/yp1/Opq/D2S1lPMjlzPQTyWhTAfQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.86) smtp.rcpttodomain=bootlin.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAOWK8zygrH4JJLvXwgmhu4Zcwi6QzVQhcvQcHQ3td8=;
 b=2yDM5zQkO/wt/1XM4Pizm17pt4xL+/xDdfubrELXX4TodtOiGpoMEDETezEa4IXKSNkDETjwJ+D/cUQs/KqKsKh0u6WRwbdnkMDw7TYGzevIDgSBCx+Y8MYodspQQnAVAMRW3otIBV98dzbmsmbnLP1/MQAzEz+MI4l+nvHSN/ZKd9idU7v+4qR5+W2rluWf361Lf3xx9Ziac3GNEo+mt88YRmeqMFoKm2p5wooTthsEnNP/UE0sz7sSXtBjojM7zsYVAGA6NLihjFJqHSSTMZVsEkF4qtUX+WljI91VwMceeIGBcoUtwU5vFH1z8i2wtFXg6pVyCRfYMx0vU4jrPg==
Received: from AM0PR01CA0150.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::19) by AM7PR03MB6264.eurprd03.prod.outlook.com
 (2603:10a6:20b:13d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 16:03:52 +0000
Received: from AM6EUR05FT063.eop-eur05.prod.protection.outlook.com
 (2603:10a6:208:aa:cafe::bd) by AM0PR01CA0150.outlook.office365.com
 (2603:10a6:208:aa::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 16:03:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.86)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.86 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.86; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.86) by
 AM6EUR05FT063.mail.protection.outlook.com (10.233.240.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.23 via Frontend Transport; Mon, 11 Dec 2023 16:03:50 +0000
Received: from outmta (unknown [192.168.82.132])
        by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 6BFF2200813A6;
        Mon, 11 Dec 2023 16:03:50 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (unknown [104.47.12.50])
        by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 417F12008006F;
        Mon, 11 Dec 2023 16:03:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3vnTz2oFLhreIl0GRs9mAkgjeHFWHv3F6fh5+yV2cotskr3uHQCWtr6B5houvCwPxxHfzHwlZPJ7hgVICbg6rwaet4poRYIiDlCHYGOgyP0twiO+OK/PkFwUZsCj2fypqyt7lMl1iIVD3Hd/xmJEfucYGmmuUvTYo7/+7Qz6smUeSlgOxmX0SkHNHxOW11ku7IhVtyKTbUw0TcIT5A2O37cdQs6nb8TCDFpX1d63km6tjXPM0s4AUdNzMWc7b92PfUw5wIVgs+O3tZSkIV+gPYS3v3ADjO0ih6Ubwo1ZwKcNuZtXdzEt+ErmLCW9r2lwf/L0I5BOcUv/ZJKtJdzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAOWK8zygrH4JJLvXwgmhu4Zcwi6QzVQhcvQcHQ3td8=;
 b=B2cyWso6TXvVmkbyQjR9rEbqju9yObPzLCuHUtP+tfgfamEllrsfwg8OAG2NDDgSZGIU2Fnhj7mR+z+ccwcOR5ad4BfzJ9R+27+CD7m5E1zZHk2AwfNVDuveY9ZHW139iVvwT+OiWLK3MXQiHyQJQ3+ANnCfj+EYMWcpIszQdxvvQqLYZ/HSbf/wJw57vgE+MtjKJb+LG/XHHCtc6D0wLlP0oB9Xc4+g+a3G7mF8gGNtWmVT5UkDNkyi4xJnVZQ3f+SulNxfaMXssqDlP32Lob2ZmGpglckAvELquUeLkAEcSQLfNmagr/k3aQW5dAupxhY6TGkWk2insQj+2+w4tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAOWK8zygrH4JJLvXwgmhu4Zcwi6QzVQhcvQcHQ3td8=;
 b=2yDM5zQkO/wt/1XM4Pizm17pt4xL+/xDdfubrELXX4TodtOiGpoMEDETezEa4IXKSNkDETjwJ+D/cUQs/KqKsKh0u6WRwbdnkMDw7TYGzevIDgSBCx+Y8MYodspQQnAVAMRW3otIBV98dzbmsmbnLP1/MQAzEz+MI4l+nvHSN/ZKd9idU7v+4qR5+W2rluWf361Lf3xx9Ziac3GNEo+mt88YRmeqMFoKm2p5wooTthsEnNP/UE0sz7sSXtBjojM7zsYVAGA6NLihjFJqHSSTMZVsEkF4qtUX+WljI91VwMceeIGBcoUtwU5vFH1z8i2wtFXg6pVyCRfYMx0vU4jrPg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DBBPR03MB10395.eurprd03.prod.outlook.com (2603:10a6:10:532::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 16:03:45 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f%7]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 16:03:45 +0000
Message-ID: <c3cda013-eab0-46c0-a89a-ed51ecfd1e1d@seco.com>
Date:   Mon, 11 Dec 2023 11:03:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rtc: abx80x: Don't warn about oscillator failure after
 PoR
Content-Language: en-US
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20231019163931.3682923-1-sean.anderson@seco.com>
From:   Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20231019163931.3682923-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:208:36e::10) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DBBPR03MB10395:EE_|AM6EUR05FT063:EE_|AM7PR03MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d05c5a6-123f-4250-a6b2-08dbfa62c407
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: +lKDBNLGagjOrFxIaVVUoy4I4WsDBWowjTca5BGREoN1z7Wn2RaaH9PeyHLOHQviRoaaS1umFEfDN8STwA0OlElJ2OFNUaY/BxHa5AYUlPcbzgnfbWu82DCa/I+rwQ7yBerlHZbc5geu6PGYx6/MX2QRoydovPZFt65Zkf6I31cIXTd9cgqLSSN8BSPgcuUTsT73ngbWQlsLhO08dicRhxROv3dwFc7VASe9PNRVarTwZxtqPco8PhqDycW8sq+yucCcWnayxiUf0I0V2LUCXZLvpaeIofoIi9lN0ACzscHJXBL8tmEphRgp6FtP5QO1aJg6Srp854FE5H1m3bnZ6b/KRFxQ7WVPXXMRfPMbcnvWAueVYK2sEWI+qwCQXDYjCv9Nf8EbFNiMU5+oY5i9Q45Fs5wOEyIcGzARb1vJ6KCc1Z1umvJPaUrxfYmuW4s/7kl+T8W7XMoFRzDwhwbAzfUWDgaVGzeTFa+Dc1rviEzyNkyOTKeD2O1dDyT408lLCt/JeDniEMfc0nxWyeNlYfnbnGsUMmt3tDa1CXT1SdCKBU6i0rpMhP01va0/N483zVkKemiIG5spdL9j1p1AfVWJ4HTvfRydxH+9INDTRxoDl7+H37PZFygg8wgvizEUT9jLX6g3n1HGn+2zXlD1pyVwGGNb5M0z4qEZ8hjwN5IMYijCR6HPDpsGTQ9WAxA1+3bhAFRCsk9eWS8iKyJP3jsEVakKcYPIDbqhs0Mgchs=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39850400004)(376002)(346002)(230273577357003)(230173577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(53546011)(6506007)(5660300002)(26005)(2616005)(44832011)(36756003)(66946007)(6486002)(66476007)(66556008)(2906002)(83380400001)(31686004)(41300700001)(38350700005)(478600001)(86362001)(8676002)(8936002)(4326008)(52116002)(31696002)(110136005)(316002)(38100700002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB10395
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM6EUR05FT063.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 34aa8a4b-d386-4dd5-3f44-08dbfa62c0a2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /dYtreir/uZYa0M+DBcQTuibEQnldZDkk3klILb72uH63Ms3/pKVfBFU7IaluHZJ72G59bjqtoEGzIyrwr9u+BLzfOcEvdFe2Z2bB8/eowsGhIl1t+715cXeHY2XC9f4qr6UAQw5meM9u/hU/4ULpJ7bxBWTvUs7cxQOiC1YNkY8hNcr4PbbhWS6yqUpMNfK1Y3wFW/ZqMS+HqzGpm1+io4RDsHxCxvKrQN4uej5yM2UCBC/1haaf9slVuAmHmkznCw+Ye3Rer2oxUYyfTT+Bt6D8EsG5hxjORdGxFfoSnYBvO4yqcwS36Mjb7TiCu8Hn8hYbkoBc1SAX4OEV0cm23ild/zKojXt1anWcED1bHKJi86cKNHH6Wv4wN/EHSP3Ze9EZru5rhyeGMJgwh9vgZvgogEtGroYmAI9OrzIiSfIDfzG8B/U42V/2d5EQm0TWdHziAL8mFjDM1Ft8FU0vB1cjGZKId6NdkNj6/F+jqUYsLOMF8wFqHx2AyTS2xP98Vz18ibsr8dtMlMs4xntCCjEH+Af1+19TkA9ImaZGF35FJX5VU8dishf//z4aKY+V4CYgSVgTQR7Ms6vZwk1I/itvkSgb7SV+QVJrek1IcKPo7e26sPQ128aCcQsQ7dbRniKC2Ok6dXIOQg8DmYjM1IFqQyu3vI+Gb1LY1BslE27DwnCDLe+6cUzZWyrELB2vVKE+CM7Ue3zkASz2ifggi5qWxSzctqRQsu615vOu4SedpmBTdbAOsEa3m79SsrDBkEfVlZebeJg5xiTjbm1gi0yK1vIkow+UbFKIOHV4KKoLPpamuKKQt+iwO9DErQt
X-Forefront-Antispam-Report: CIP:20.160.56.86;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:inpost-eu.tmcas.trendmicro.com;PTR:inpost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(39850400004)(376002)(346002)(136003)(396003)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(64100799003)(1800799012)(82310400011)(36840700001)(46966006)(41300700001)(34020700004)(36860700001)(47076005)(336012)(26005)(83380400001)(2616005)(82740400003)(86362001)(36756003)(31696002)(7596003)(7636003)(356005)(44832011)(5660300002)(316002)(8676002)(8936002)(4326008)(2906002)(6666004)(6512007)(6506007)(53546011)(70586007)(70206006)(110136005)(478600001)(6486002)(31686004)(40480700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 16:03:50.5163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d05c5a6-123f-4250-a6b2-08dbfa62c407
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.86];Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT063.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6264
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/23 12:39, Sean Anderson wrote:
> According to the datasheet, the "oscillator failure" bit is set
> 
>> ...on a power on reset, when both the system and battery voltages have
>> dropped below acceptable levels. It is also set if an Oscillator Failure
>> occurs....
> 
> From testing, this bit is also set if a software reset is initiated.
> 
> This bit has a confusing name; it really tells us whether the time data
> is valid. We clear it when writing the time. If it is still set, that
> means there is a persistent issue (such as an oscillator failure),
> instead of a transient one (such as power loss).
> 
> Because there are several other reasons which might cause this bit
> to be set (including booting for the first time or a battery failure),
> do not warn about oscillator failures willy-nilly. This may cause system
> integrators to waste time looking into the wrong line of investigation.
> 
> We continue printing a message about invalid time data or an oscillator
> failure. There is no voltimeter in this RTC, so this is the best
> indication that the battery is dead (or dying) and reeds replacement.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> Note that the following drivers all warn when they detect a problem with
> the oscillator:
> 
> drivers/rtc/rtc-ds1672.c
> drivers/rtc/rtc-pcf*.c
> drivers/rtc/rtc-rs5c*.c
> drivers/rtc/rtc-sc27xx.c
> 
> So warning about such an error has good precedent.
> 
> Changes in v3:
> - Use info since this is a good indication of a battery failure
> 
> Changes in v2:
> - Use debug instead of info in the typical case (no battery)
> 
>  drivers/rtc/rtc-abx80x.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index fde2b8054c2e..f463a58a240b 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
> @@ -127,6 +127,7 @@ struct abx80x_priv {
>  	struct rtc_device *rtc;
>  	struct i2c_client *client;
>  	struct watchdog_device wdog;
> +	bool wrote_time;
>  };
>  
>  static int abx80x_write_config_key(struct i2c_client *client, u8 key)
> @@ -179,6 +180,7 @@ static int abx80x_enable_trickle_charger(struct i2c_client *client,
>  static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> +	struct abx80x_priv *priv = i2c_get_clientdata(client);
>  	unsigned char buf[8];
>  	int err, flags, rc_mode = 0;
>  
> @@ -193,7 +195,18 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  			return flags;
>  
>  		if (flags & ABX8XX_OSS_OF) {
> -			dev_err(dev, "Oscillator failure, data is invalid.\n");
> +			/*
> +			 * The OF bit can be set either because of a reset
> +			 * (PoR/Software reset) or because of an oscillator
> +			 * failure. Effectively, it indicates that the stored
> +			 * time is invalid. When we write the time, we clear
> +			 * this bit. If it stays set, then this indicates an
> +			 * oscillator failure.
> +			 */
> +			if (priv->wrote_time)
> +				dev_err(dev, "Oscillator failure\n");
> +			else
> +				dev_info(dev, "Time data invalid\n");
>  			return -EINVAL;
>  		}
>  	}
> @@ -219,6 +232,7 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> +	struct abx80x_priv *priv = i2c_get_clientdata(client);
>  	unsigned char buf[8];
>  	int err, flags;
>  
> @@ -252,6 +266,7 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  		dev_err(&client->dev, "Unable to write oscillator status register\n");
>  		return err;
>  	}
> +	priv->wrote_time = true;
>  
>  	return 0;
>  }

ping?
