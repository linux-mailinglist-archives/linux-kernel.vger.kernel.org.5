Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB9176FBA2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjHDIFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbjHDIFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:05:10 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2048.outbound.protection.outlook.com [40.107.14.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49324697;
        Fri,  4 Aug 2023 01:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spS4MoxUW93NIpABhPuKV0mlNfojgGW4xfhmX3MIctA=;
 b=rQc6RXoq+XZW5F72BcKJa8eXSPIVn5e7AaF7NTdCipivX2mB+yiG4a78lk/Ii9s4QxkmytM6bVXqefO1sObqXpNpfVRroTkGC38hldLV8dxjK41G5Kj7qpfi6gGEdmths3sq8XzTR8J2Iyj+/HTmaQ3lIXFHxN1mHzOtGvhe2QA=
Received: from DBBPR09CA0027.eurprd09.prod.outlook.com (2603:10a6:10:d4::15)
 by AS8PR08MB8924.eurprd08.prod.outlook.com (2603:10a6:20b:5b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 08:04:58 +0000
Received: from DBAEUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:d4:cafe::7d) by DBBPR09CA0027.outlook.office365.com
 (2603:10a6:10:d4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 08:04:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT049.mail.protection.outlook.com (100.127.142.192) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.48 via Frontend Transport; Fri, 4 Aug 2023 08:04:58 +0000
Received: ("Tessian outbound ba2f3d95109c:v145"); Fri, 04 Aug 2023 08:04:58 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1861e5a8b6ca73e2
X-CR-MTA-TID: 64aa7808
Received: from 918d12e3b4d1.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 96F790E4-67C8-4D42-BA0E-C7AFB4B273C0.1;
        Fri, 04 Aug 2023 08:04:51 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 918d12e3b4d1.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 04 Aug 2023 08:04:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRCLCO+on4Yl2XgngKzzqgONYVQ4iuLQ/CBLw2NMJLkTv3um6IesrqbBS8BKIuyuilCRHNxENfHIfuirq+ZBXOQxBwVd1bHHzo4YifegfxVDeXfzdDGTu6vEjWKA4YNOYRQyn1KTSJaAuSCiYy7vRM7Gn4svm+XXYIUJGcxJ82CEl0DLrX5CNl31yuilfTL0SmPbXr4vX3C0QNvgRRzt3svN0ACbAz6T7sJfertVFhRCtWKDkNGhY0AloglMJM1p66JYCnoWmOMlnvRygZwE+HGknsi0ftfjEUH1cYwGEni6feRkcmvhJiLFJfwdKkhlqK6VCvhuZboHBAG+hZhTPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spS4MoxUW93NIpABhPuKV0mlNfojgGW4xfhmX3MIctA=;
 b=f0sI1PZ4qiSulNnkJvPjv32VObGGoWgI1hXWmOOPQ0gHHU/UbStwxiZz790MYdLDn/4QbcNjPbv5gvj0D0gylNWio/9yGdRcrYS10VmLV8Q1pEP0+kul9nxP2r3dISrzppA3JxPK1Mq5AhQ1J3D2D+q8s01rVtXOveCU2zKVpszPSIZlKZ73TOZtHVYV2ZK/b8v8zAhudMPJ/1IqshjDgaMl7I2FG4zFJUK01qmpAMaxvc+gi3yGKCwxVc3xsAle8MstaTiurwB3Lc5GUOLZW04HRWjlsBa0Ex70iZbautnXswDk96v83GbwsDgVDjA4f+349q1HQ4k/dC48clBdVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spS4MoxUW93NIpABhPuKV0mlNfojgGW4xfhmX3MIctA=;
 b=rQc6RXoq+XZW5F72BcKJa8eXSPIVn5e7AaF7NTdCipivX2mB+yiG4a78lk/Ii9s4QxkmytM6bVXqefO1sObqXpNpfVRroTkGC38hldLV8dxjK41G5Kj7qpfi6gGEdmths3sq8XzTR8J2Iyj+/HTmaQ3lIXFHxN1mHzOtGvhe2QA=
Received: from DB9PR08MB7512.eurprd08.prod.outlook.com (2603:10a6:10:303::14)
 by DB5PR08MB10161.eurprd08.prod.outlook.com (2603:10a6:10:4a5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 08:04:48 +0000
Received: from DB9PR08MB7512.eurprd08.prod.outlook.com
 ([fe80::9ea7:8451:f005:704d]) by DB9PR08MB7512.eurprd08.prod.outlook.com
 ([fe80::9ea7:8451:f005:704d%4]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 08:04:48 +0000
From:   Al Grant <Al.Grant@arm.com>
To:     Anshuman Khandual <Anshuman.Khandual@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Anshuman Khandual <Anshuman.Khandual@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] coresight: etm: Make cycle count threshold user
 configurable
Thread-Topic: [PATCH] coresight: etm: Make cycle count threshold user
 configurable
Thread-Index: AQHZxo7SJwk5KsJnwEOgjuWw4bjf06/ZxJDA
Date:   Fri, 4 Aug 2023 08:04:48 +0000
Message-ID: <DB9PR08MB7512B9A03A86B8983884B1C98609A@DB9PR08MB7512.eurprd08.prod.outlook.com>
References: <20230804044720.1478900-1-anshuman.khandual@arm.com>
In-Reply-To: <20230804044720.1478900-1-anshuman.khandual@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 6ED84E0D25F0D94FB5A8457DB2080837.0
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DB9PR08MB7512:EE_|DB5PR08MB10161:EE_|DBAEUR03FT049:EE_|AS8PR08MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: e34780ff-3500-499e-342a-08db94c17f2c
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Ey/Wy5o8cDVJZGu5v+SDKD8TXYfC/3tP2g6byOgBriL013EpNy6aKkvn0PPR0ISQESYzwbXVuJUfSZIqKlGQCeNfnebBAza9DLUMKiENFU6hxbouKcd8S/jfyhTct9sFCm2E9x/eS/a0QWsGSqWoxouMweWiLOsxCPuKM8SxOpMamcQuX7KLA+yKLoXEDMBwQPzgyPWEccG2rJVP8lNY9XniwXC0b3ff6WND/qXQ9EPdqi0TOaxpT5wpSCZghjaZMEIOSA24BDjPin9ylACNhUhpU6GqleD+cw1eu5uA4ckagrtxl3gM52/Il9kOdnyECqbkBfAdTrao6Ht2Kb1sRRj/HGfgv5Lwm2rHpgq2Ki881a1htCoeKFg1jz6WkgIHamdS8W3lCvioHO726SudEvDavaTYQULskU3gE/ecjF6kwp7ce2/N8oDuwMzYLy3tD/i+C3WgRxeUilIFON2PgpuEgeP2jPkIcmRZh25tpdZuEbBaNjkkpmkq2gDnsah8AKjMtFSjuYb2LUipgVoucoJfLczHYaFSJPXtSgBKvofsvLNDtT2bgXGyaw3tRlv8yPNhGSWkkOFS7pc1FLzhXc65fklKfNTDVN6OgNl1EnuM4thmX/k6R5bwLsFQ0AY5
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7512.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(1800799003)(186006)(38070700005)(33656002)(86362001)(66899021)(110136005)(54906003)(478600001)(55016003)(38100700002)(122000001)(83380400001)(6506007)(26005)(53546011)(41300700001)(8936002)(8676002)(9686003)(7696005)(52536014)(4326008)(71200400001)(66476007)(66556008)(66446008)(316002)(64756008)(5660300002)(66946007)(2906002)(76116006);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10161
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT049.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3adc4a3d-41c4-44ed-09ec-08db94c178e9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cjrMbiDFTNjyKnU/+wvt7rDOeoLs5UeQPM+6WdZfOpeQ2o7feh2RfqCU0gcdsBrT6mu5qkfs5VgMQtAFA2sIuEEQlgXWp+qLwABZPHs4iicP5Wlg2Non12BnnTgwZLw4c8q+eepcc3GUMCRmLTa6spt8usuWI3uwVQ4BzyxBiQltjuHN/V5iRjAODtmNVPKBubeWjrFINAMxTWGbZ8L+F44oVCFe47LWvJONfyHFVuIyqWBQVz4fh36Py5hEpnRWXJK49uYliPqtG1lRxHisgHXpBcEA6DfxCvzMckI+mfCX4hbI9qJyDTwHX3KdvS8wjRK5cSh5CKbTwoXX8zG1Jx5SlFEdr3VBfGVqKCTyuCzdQEi7nGdNDjW0cdUEwMEo7Y0t948h0noOFNI2XzAfLc6m7nd+pcqu4LH+pNX25h8qY8r2+Vb6tUJpzay+TxTgiZL6RvzVCzaNEJlMHSQJAeaxwURl0nsaGWBAsXt7Ft8nERwdigw5J1l1T4DJ+W5CItdH1YErYJjgUpZC029Al2TE/EBwP1OXjPrcfHkM7h5fikZIlduGEJG/9e1PGBrbVQIv/146rOUiIOu6gut1gtMOniB/km0mEsTtxms8fVNbAXN36/xBLFiUqGoXhyxparHQSRBI4ysvDCNuDbpDcxlzb/9ATVSm2f4F3fow/6u4OydoR66CKd7J4ZRHfS5Io9sTrxumFQh9VpzSGzHLbMvwZTvY5D7I5fAjwSqUcPcezCe0yTsoA4tW1f+Xg4YQ
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(186006)(1800799003)(82310400008)(40470700004)(36840700001)(46966006)(7696005)(9686003)(40460700003)(86362001)(40480700001)(55016003)(6506007)(36860700001)(26005)(336012)(53546011)(83380400001)(47076005)(81166007)(33656002)(82740400003)(356005)(450100002)(5660300002)(41300700001)(8676002)(8936002)(4326008)(2906002)(70586007)(70206006)(316002)(66899021)(478600001)(52536014)(110136005)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 08:04:58.6259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e34780ff-3500-499e-342a-08db94c17f2c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT049.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8924
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Anshuman Khandual <anshuman.khandual@arm.com>
> Sent: Friday, August 4, 2023 5:47 AM
> To: linux-arm-kernel@lists.infradead.org
> Cc: Anshuman Khandual <Anshuman.Khandual@arm.com>; Mike Leach
> <mike.leach@linaro.org>; coresight@lists.linaro.org; linux-doc@vger.kerne=
l.org;
> linux-kernel@vger.kernel.org
> Subject: [PATCH] coresight: etm: Make cycle count threshold user configur=
able
>=20
> Cycle counting is enabled, when requested and supported but with a defaul=
t
> threshold value ETM_CYC_THRESHOLD_DEFAULT i.e 0x100 getting into
> TRCCCCTLR, representing the minimum interval between cycle count trace
> packets.
>=20
> This makes cycle threshold user configurable, from the user space via per=
f event
> attributes. Although it falls back using ETM_CYC_THRESHOLD_DEFAULT, in ca=
se
> no explicit request. As expected it creates a sysfs file as well.
>=20
> /sys/bus/event_source/devices/cs_etm/format/cc_threshold
>=20
> New 'cc_threshold' uses 'event->attr.config3' as no more space is availab=
le in
> 'event->attr.config1' or 'event->attr.config2'.
>=20
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: James Clark <james.clark@arm.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  Documentation/trace/coresight/coresight.rst        |  2 ++
>  drivers/hwtracing/coresight/coresight-etm-perf.c   |  2 ++
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 12 ++++++++++--
>  3 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/trace/coresight/coresight.rst
> b/Documentation/trace/coresight/coresight.rst
> index 4a71ea6cb390..b88d83b59531 100644
> --- a/Documentation/trace/coresight/coresight.rst
> +++ b/Documentation/trace/coresight/coresight.rst
> @@ -624,6 +624,8 @@ They are also listed in the folder
> /sys/bus/event_source/devices/cs_etm/format/
>     * - timestamp
>       - Session local version of the system wide setting:
> :ref:`ETMv4_MODE_TIMESTAMP
>         <coresight-timestamp>`
> +   * - cc_treshold

Spelling: cc_threshold

> +     - Cycle count treshhold value
>=20
>  How to use the STM module
>  -------------------------
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c
> b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 5ca6278baff4..09f75dffae60 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -68,6 +68,7 @@ PMU_FORMAT_ATTR(preset,		"config:0-3");
>  PMU_FORMAT_ATTR(sinkid,		"config2:0-31");
>  /* config ID - set if a system configuration is selected */
>  PMU_FORMAT_ATTR(configid,	"config2:32-63");
> +PMU_FORMAT_ATTR(cc_threshold,	"config3:0-11");
>=20
>=20
>  /*
> @@ -101,6 +102,7 @@ static struct attribute *etm_config_formats_attr[] =
=3D {
>  	&format_attr_preset.attr,
>  	&format_attr_configid.attr,
>  	&format_attr_branch_broadcast.attr,
> +	&format_attr_cc_threshold.attr,
>  	NULL,
>  };
>=20
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 9d186af81ea0..9a2766f68416 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -644,7 +644,7 @@ static int etm4_parse_event_config(struct
> coresight_device *csdev,
>  	struct etmv4_config *config =3D &drvdata->config;
>  	struct perf_event_attr *attr =3D &event->attr;
>  	unsigned long cfg_hash;
> -	int preset;
> +	int preset, cc_threshold;
>=20
>  	/* Clear configuration from previous run */
>  	memset(config, 0, sizeof(struct etmv4_config)); @@ -667,7 +667,15 @@
> static int etm4_parse_event_config(struct coresight_device *csdev,
>  	if (attr->config & BIT(ETM_OPT_CYCACC)) {
>  		config->cfg |=3D TRCCONFIGR_CCI;
>  		/* TRM: Must program this for cycacc to work */
> -		config->ccctlr =3D ETM_CYC_THRESHOLD_DEFAULT;
> +		cc_treshold =3D attr->config3 & ETM_CYC_THRESHOLD_MASK;

Spelling again

> +		if (cc_treshold) {
> +			if (cc_treshold < drvdata->ccitmin)
> +				config->ccctlr =3D drvdata->ccitmin;
> +			else
> +				config->ccctlr =3D cc_threshold;
> +		} else {
> +			config->ccctlr =3D ETM_CYC_THRESHOLD_DEFAULT;
> +		}

Consider dropping the check against CCITMIN. There are CPUs where
CCITMIN is incorrect, e.g. see published errata 1490853 where the
value 0x100 should be 0b100 i.e. 4. On these ETMs it is possible to
set the timing threshold to four cycles instead of 256 cycles, providing
much better timing resolution. The kernel currently does not work
around this errata and uses the incorrect value of ccitmin. If you drop
the check, and trust the value provided by userspace, you allow
userspace to work around it.

Al


>  	}
>  	if (attr->config & BIT(ETM_OPT_TS)) {
>  		/*
> --
> 2.25.1
>=20
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org To unsubscribe send =
an email to
> coresight-leave@lists.linaro.org
