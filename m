Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8A980ED0A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376545AbjLLNP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376544AbjLLNPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:15:53 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A25CA;
        Tue, 12 Dec 2023 05:15:58 -0800 (PST)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCBWuHi021687;
        Tue, 12 Dec 2023 05:15:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        pfptdkimsnps; bh=lvWdXRvohYX7Gjf+Zl5w7E871KRB3M0cWyG31/oXekc=; b=
        eRiE4kdgNdIqnqLqhGg4sVjtl2GNRI464XCv2r9eRZ5hCcXgMNQyJ/d0JNlL4xw/
        xkGd0Z3VMmBAIEBOaKyjIN5K190jJ+6t6ROonRwRuVgf9qxZM5br0AZnb22si3PG
        4sxsQcbOYlQ0BvvZhiObVgearc96a8aYzcNANAu2h+xKcUYD0dhYM4BSl5e2MU5/
        MBi3IsqACUxpZ9RsZrXzdRqMMBSPXvOGxhKcTvuikmE9zjH5ChMPUa3kuliJtjhC
        yvo63Xdby3yw1q83rW1eRKAGFCPy+JyMeLFztSOhttWlWbPWO8N9TqR/SXyz5kQV
        M4TR00H5FEYSUsdxxtvzTg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3uxd5936g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 05:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1702386917; bh=lvWdXRvohYX7Gjf+Zl5w7E871KRB3M0cWyG31/oXekc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=dNO3RqAw//KHGLCs1dmP9WA3X4rw6W/61zfCpSsnrsrvEwPZ40YSrfX1OESuW9GpN
         rOrUZwZ8whq0nuTaa6ImEwaef2IsQmuQjUbmnW1BJSeB/XP4TLsAM5oFv0sOuyU7be
         RbzUzSt3nwH8P82OQKRyawJHhoDuLcwLduTGlODfC/YoGGicDNrFJYQvlqTJPXZ51Q
         9Gm2kPimMx+rCRRJwJB3VDNKtm6bLgtmAIWfxcexUSsF8x/a8oKSZukMR53kMAfyt8
         Ril81q0UKX34Ld+bKfSwJZPBY5LZiIWWlWGh4U2mLbvQuhEM1IiuiuKfGl+CwIGke2
         SddwacubhMg4Q==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3860540141;
        Tue, 12 Dec 2023 13:15:14 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id DF459A00B1;
        Tue, 12 Dec 2023 13:15:13 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=S5Khrrph;
        dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9195E401CE;
        Tue, 12 Dec 2023 13:15:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReLWL34J5aToCDuAO+uClnqRZVftnZoYIy8aIahSYs8jKQiV9dh4DfIEefquID8K7eNozxUoFmcfMQ5rvvZeX4/TvTy5FDTxiS8BDQ7R3YhpIdQXPBMdQx77WqY8X1VVLFaWZ8ZhAVzmwEjCv5GW46XbkPGOJGJesDFGEtyTfmXiFdOtJNVcrHc8y/OOVzeSwN6dbGG0CeX7tZejTT3aFk9BmdKvihqV/RYzDjRhkJNqzGhbUSYNfxoDayx4lVW0oAlIvifQXmdCpQpLrbDrNbYREPEsC9ChbyZWxlBdjUTqtCSLRibYH5IA4TZLZAp6EEx++3roAXIc2NQO8kk9xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvWdXRvohYX7Gjf+Zl5w7E871KRB3M0cWyG31/oXekc=;
 b=BA9uhP/l3yzCxxumvU+BTbSfrVW9icn1Kt70OgMeMgEvog/wilQmnowbgUgHLP53lju8qQCy62+E0UJ9B4GlJBBMgdwPNhPJSVsMLKi0D+zdtjPk5Z0z2Hl5zRRoB9joM1OnSKgkguUMtdv+P7R7gIG0L8a92ykMF9n88CMPHd+u1efvQEAwU/yWwUVoAYHachQUBu53tPwejRoepYPthZPglskgVKCgUQr0ZyEbEs0EnrO5ZwThl0BQjbVbmdoqEWrlRxC6KAuYCSRsbRsRKbzd2wKjbQ9g3LDW5wA6gh9g4Mx06mW6rbh5frY0ZGPas83b4+VUND3WXU2Z7/YWUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvWdXRvohYX7Gjf+Zl5w7E871KRB3M0cWyG31/oXekc=;
 b=S5Khrrphah3cA3OXgKh2b2ZhgIVOq4o0xLY+7DRu/FeIl2NY6QwrT5VFopxZRkoZ/daNAwtAMHHo5jr7WqRKuRNamoN1V/W1tfFn01Ws/vbzOqXK4/dEPN80HJqYbmqZT+2th949zOZDNIOpCJrqyXkT0G5TOtQaoN43C+MJ3t0=
Received: from SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9)
 by CYYPR12MB8922.namprd12.prod.outlook.com (2603:10b6:930:b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 13:15:07 +0000
Received: from SA0PR12MB4413.namprd12.prod.outlook.com
 ([fe80::12ba:707d:284:a4de]) by SA0PR12MB4413.namprd12.prod.outlook.com
 ([fe80::12ba:707d:284:a4de%7]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 13:15:06 +0000
X-SNPS-Relay: synopsys.com
From:   Jiangfeng Ma <Jiangfeng.Ma@synopsys.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Johannes Zink <j.zink@pengutronix.de>,
        "Russell King (Oracle" <rmk+kernel@armlinux.org.uk>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        James Li <James.Li1@synopsys.com>,
        Martin McKenny <Martin.McKenny@synopsys.com>
Subject: RE: [PATCH] net:stmmac:stmmac_platform:Add snps,xpcs devicetree
 parsing
Thread-Topic: [PATCH] net:stmmac:stmmac_platform:Add snps,xpcs devicetree
 parsing
Thread-Index: AdopoV2G4U4p6KhERnimGhWz15HefgADSasAAA0RnAAAt6TJAAAOlyww
Date:   Tue, 12 Dec 2023 13:15:06 +0000
Message-ID: <SA0PR12MB4413B8B6EDF08A1075E0B5AFD98EA@SA0PR12MB4413.namprd12.prod.outlook.com>
References: <SA0PR12MB44138E48A245378CF54D2F9ED98AA@SA0PR12MB4413.namprd12.prod.outlook.com>
 <20231208091408.071680db@device.home>
 <uzss3af2cklc5bx5apszoegafeaaiv7o7iwgrgrml4grkyev6p@6tme4hdb4mkn>
 <SA0PR12MB4413305305D47CAAAFEAD528D98EA@SA0PR12MB4413.namprd12.prod.outlook.com>
In-Reply-To: <SA0PR12MB4413305305D47CAAAFEAD528D98EA@SA0PR12MB4413.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcamlhbWFcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy03NTIzNmEyYi05OGYwLTExZWUtYmFhMy1jYzk2ZTU2NGY4OGJcYW1lLXRlc3RcNzUyMzZhMmQtOThmMC0xMWVlLWJhYTMtY2M5NmU1NjRmODhiYm9keS50eHQiIHN6PSIxMjY3MiIgdD0iMTMzNDY4NjA1MDMwMTk4NzU4IiBoPSJRMHFWMnBkdWFTRzlScUo3TDloVzBYZDVWUFE9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR12MB4413:EE_|CYYPR12MB8922:EE_
x-ms-office365-filtering-correlation-id: 121cccf4-26e4-42d3-0902-08dbfb145bf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pSTzIOdBv3T/+sLzm4Fd8NkGSAJ88O2q2fP1hxLQUt8t3qnNrdWVPNmcV+FKwXLg8HDCsPK7Sy+Hix/6QbEEYiAT+ukzeAS5qUaVAhdOFqbHctgYqIz0VqH19uBbIV4VglSP2ws76uxUz97vNdNlzpOR5xOBe/5LerIbPQzdS1WBRiZ99I3gDpc+mPsuOxIDI351R0Hqqx0GpzShswo5DPgBRpFhhnla3o0yshgzmdQucPfPJS5B0q332BU6YWU6P2vg8PRuGL3PY3GIdWCdNzNrp5txsOpVqmbOiRzijVZ3U3ynAKZWIw1NSJa58g82cKSF9rFe2b0kzyjbc80BbdnhN7GBDFdjTcrWfw6z7eJEHX8+2NWRB3moVkFAGtFCPjKO7hjoVtUt1C7EPC+PTM3gaDAVSS2gjQzxk7MF7gJJWPNvby1zO0zl038OzMGDKmaxm5xSSK8+pmjHo72khRPnJwpapT71ZRrN2Ool/t5HeS+pDI7efPxTybFch226SWKgc9YzQbmGQgR8qDxXysmWsOLSq1dmo/aOErVUsDn2FLmIgKDTjPx6yWNb1BjeQM95+gNOE3c1OTIAyfc+FjnRZnhGgOJUXbA8RPeUZUA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(52536014)(5660300002)(55016003)(4326008)(8676002)(8936002)(7416002)(2906002)(316002)(66476007)(66446008)(76116006)(54906003)(64756008)(66556008)(110136005)(66946007)(53546011)(19627235002)(966005)(107886003)(41300700001)(9686003)(478600001)(2940100002)(71200400001)(26005)(83380400001)(33656002)(6506007)(38100700002)(38070700009)(86362001)(7696005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWErZWo4WkYvRHE3KzlYbTdjQmtyQ0JPWjBkcitZNERFUHJoT3FFQnVYY0FD?=
 =?utf-8?B?RFFhVVd6eURqWTJ6SS9EMFFtMGNvY3orUzV2cGVlS1htUnlXaXpkamNLeUlp?=
 =?utf-8?B?RnhIM2ZJZm1tMG9DZUNBbkVrclVNVWdieU1wZ25FM3JLMmVCc3ZESWFNUE02?=
 =?utf-8?B?NVYvSXpXU0U4SmZNb3ZTNlArVUEzS1hxK2o3eDVmSGZwd1kvSXZReFZad21v?=
 =?utf-8?B?RWQ4ajBmYjFqcTFQZ1k2dHQyREtJMVpCL3lCUHZMM3hlN284QjlzOTUvN1Yy?=
 =?utf-8?B?VHNnU2prNDNLenFXeGtTZWZFbjN0NEo0MlNmc01wcXMvWW9pdnl1eG4wVTM2?=
 =?utf-8?B?Sm1RSnpGTE16aTdoUkU5Ukc5Y3c1UGJWYnFWa0dCVzd0TzArK3lqQmx1NjVy?=
 =?utf-8?B?RXUveUpCdTIrazVNMldYejhZclQ0VHVnamNDNkhBOEdlbVMxQnRPSTF3Wk04?=
 =?utf-8?B?NDZuakRjRDd6MFJ5WTZTNU9VMlE5ZWxJd2NzM1hnczVYdEJFMVZCcFpxaGpQ?=
 =?utf-8?B?STN5elZlNDZRZWVBeFJ3R3BKTEFnTk5hWXU0VEh0cFhsUXIwM0p6YzArWkhD?=
 =?utf-8?B?a2JDeGFoblkyb2xMOTNOdWFjeUlOU2R6WklVWk80OWNhUFdaclJGc3lwbnMx?=
 =?utf-8?B?Z05JODRhUGFXK3l5ZXNkN1owQlBZTURQWU1sU09JdkM3RFhseC83STlJTmxt?=
 =?utf-8?B?ZFArRnFxZE1vQnM3Nm0zU2RmdWVGemJSQVh2d0hNVlVZa3FPajRHcVRPSS9a?=
 =?utf-8?B?WTdhd2dyVndscE05bWY5K0RLSFRmeUp5dU1TWmtsS0Y0eGRMUEFWMnNTK3Rp?=
 =?utf-8?B?U2lOOVQ2b0M3czN0SlBWVzB4TGhKVlh1RjA3N3FFZzVsbXNKOUFKTHU4MVJX?=
 =?utf-8?B?UUYrTTVlVzZRN0V3RzY5RFlBU3dVMm9KVFB0NzQveHlTSThwemZvNXQ3OVJZ?=
 =?utf-8?B?bnVzbENxSUpUYi9ZUitQQ3crUXM4THRiMXFWbVpFc3d0Y2htdksrS2hhaXAz?=
 =?utf-8?B?bFZIdnlhREV1allwRXE5V211Q1pIY3p5VWJQajVrajhlRTMvdTBjQlJQVVN4?=
 =?utf-8?B?WWFRbXZhcDZqRkJmclhVWU0wSDNURjlUeWRBSE5aMDU5WTJpdmJsQ2sySDJM?=
 =?utf-8?B?MlhPMGlyYkE2cUE5T2g5cjhkellZMUpCQ09MWitRdXZaK1ZMbXJzbkRUdGd4?=
 =?utf-8?B?U2Z5aHFkRU5uMk5ieVpFYzRJUnltVE00UEZ6Nk45dDRIbWx3NDQ0ODlIV2RF?=
 =?utf-8?B?cHBNc01DaVBESVYxRTNQVzdQRlh3TFN4cDdUUU1YL1NpS0RIQnk2cExYMURS?=
 =?utf-8?B?NkhzUnB4UWdFclJWN3pIcVFWdTJLMkY0S053UE5zK1pBd1FZZ01Vd21kdkUy?=
 =?utf-8?B?K05oMjh6YmhBZk9YMXBRWkNpdHdYYzYrR3lZTm9kVExWSE1OMXBKTUlRL0Ji?=
 =?utf-8?B?S1JHcnJSZGxLNXE5Y0RqcFdTTjhadE5NSmN6azhaOGg1WFBiUHlrcWJyemdM?=
 =?utf-8?B?aVZndGpIZ2RTQnpKTlNkZTdvSmNZbC8xODNyTnpHNHJOaEF5MnhDSUZUYVlV?=
 =?utf-8?B?NlhiNC9sbEdWTEhKVFY2eVRBdVdVRjc4dTg4cFdwU0lhRVd3UGs2SER3eHhX?=
 =?utf-8?B?UWRrL3RZcjVqSFVjalFlU3hwUlZncnk1eVk3M055V2M2ckY5ZzFCdCtyRXhi?=
 =?utf-8?B?SUJVOUQ4bkV1MDgwU3daY2xTOFZGY1QxVklSd3BwZWUveXVCcVRTQjRUUVk0?=
 =?utf-8?B?b29nYVdXaDgwamhnVmNVWjJpUFVWSGc2NGtPcmQvbFVsZ2QvRGs0QXV0d1dj?=
 =?utf-8?B?SXM0NlNvWmYra1U5VWRuTnZ0OFEzZXRDOFZXTklNaDYzc3FrY1hmeDlNNysr?=
 =?utf-8?B?d0VVVVpRSGtkbFNSY2RNWWh1bTJ6OXhialcvZVQzQ1FMcENHNytpZ1Jva2Y3?=
 =?utf-8?B?R3dyY3J5and6WjFyVVVQaTY4eUp3YTBySXVrbFZFYlNZV1hKQ0lJcVVoQ0lS?=
 =?utf-8?B?bjQ1VnVlOWNIVUQzK2lZRWZzcDU3ZkhOM0llVGMwK0lYRXgwd2pGN1JzQVlB?=
 =?utf-8?B?YUhTQmpQdlZ0N29odU5RbVNOekpOVmt4ektpM1BrRTFCSW5EMjYzNHE1UGJ2?=
 =?utf-8?Q?dv90=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Vm1JOEZSTHRMMXYxU0JKVkFINEE4Vzk4SGRoV0hxRGlGd0l0NXM5MWxTOHBa?=
 =?utf-8?B?a2YyQWIvMW1QdmtTU3lXY2dEMzgrd1RXUTY2RU5xd1hQSCt1M3BoMUoxby9i?=
 =?utf-8?B?ZTMvSmg3bWMvNEhrOVdDSjA1bVVyME5BRVlZYU9GUmNaOTFsSWRGSkQ5SmZj?=
 =?utf-8?B?UkJ5KzFGQnpNMVdVQkJhalIxRlZ6YzFTcEJCTFRjMmcramRmeUcrdVYxOW0v?=
 =?utf-8?B?d1UrV0MvdlhTTWt4R3laOEllZTR2OVk5ZVlhV2JkMjlJN0JZdW44K0ZUNUcr?=
 =?utf-8?B?WFNlK2twdjFmcjdhMVBla2pCNUZTODNxQ1dnWEZUM2xNbzdmeks3VEgwTVBj?=
 =?utf-8?B?eWYyakJDcU5yOGI1Q1dMbUFXTmpXNmRwUzFkQ3RTUEl6Z2Q2ZlcxTVkzV3Zk?=
 =?utf-8?B?dVFaSDdZaFRjWjdmQzQwVXppU05jTVFyclVhQkJyMHZEV0plUkdzVzVZVCty?=
 =?utf-8?B?aXdEY0NqNXZWT0VMQ2tBdzJHSDJKNzJiZVE2SDRtZk5tdEVKN04vZFlQZ0Zy?=
 =?utf-8?B?STQwNlNNQXpnamhlQmljdXZzQ0xCT2xGd09WcUtHM0Z5eFJveC80NTl1THRk?=
 =?utf-8?B?d2FYRHlTRnVCNFVDeFk2UnlxcmNna1RBdnBkYXpKT21ndDdtaG12ZXlFdnBu?=
 =?utf-8?B?UEQ2SWRGNUplMTlxT3VocHRWdUZQSGQxVTdDd3JVR1M4ZHU3R3Y4dzd1T0VG?=
 =?utf-8?B?bjhETTJFcUJ2My9Oc09Ddjlsc0kzQ2RGUXZzaUNmNThRa1VIOStlS2w2ZkpO?=
 =?utf-8?B?UzhFcEVDamhLK2toRVFJZXJFRmVCR1JHVlMrTU1JL2xPU1lUZ0NvMEFLOHpZ?=
 =?utf-8?B?ZmtnM1o4anp5YUcxUWljMm1mN3J1OGRqeWJsMTRZMHVEb3Fva1Vvem91Sys3?=
 =?utf-8?B?K29iY0MySWZick53clpndTRYWWJlSHR4eEMwdkpCSHVSYzVyK1BCdFF0cnZM?=
 =?utf-8?B?TTNjTWxLY1YybExNdnlxbXFnbk5xcHZmTzI5T2Q3YTZRdmZEUndhcTJ1ZzJj?=
 =?utf-8?B?Y25VU2Uxd1g2aEVvQmw4RnRiSk1Sd010NHBvMmpZbHpyVmpNeUVBOWV2WnFl?=
 =?utf-8?B?bmp4amVob2E3bWU4elhzVmVSNGcxR1orRjRMbForcjdiNFVOdW5yTDFkRHNW?=
 =?utf-8?B?OWZCZ0V3NEIwL2dveFdkNG42VUNCU1NjNVhweXkxMjFGc2dHSE9nTTdiSzdV?=
 =?utf-8?B?ajVPcFVWblBoRmJuMFdBRlA1bG5qY0FTNkMvT213MCt3dEhIRmRLdWVkalBh?=
 =?utf-8?B?L3pSL3RXZmwvYk5NUTJWRGlZcE93R1hJallrc3pVbmlGekJJamNQU3V3M0Rt?=
 =?utf-8?B?WjZjaFZURjJtUVBTMGZrNXJQc0VsdzJkZWZUNUhoWmxTZzRKT0JKK3p2ZG5S?=
 =?utf-8?B?bkM5K3o3bDdJZndaUVFqcXJnc0tjeCtpMGY0YlVKSy8vOWsxWngxa1FPOURL?=
 =?utf-8?B?bXUreVlibzFBS2NWOGo4dk9MYkNZSFNwZmZ2U2NnaEJSYWVzWkVpZEVhZktD?=
 =?utf-8?B?Ny9BL3pXaXRweE1PVWx1czZ5akJwditZaHMyYWtQVlVwUUN5clpYT2JPUUN4?=
 =?utf-8?B?aEtWVUJONzlhN25tOFh2djJUdFZUdGR3QjdVZ3czZUtTS1FhUm1RYlFaSnR0?=
 =?utf-8?B?Nkh6a2dLNE1ETGNRYnJUMDNqN3lJSDNjOG43UzE0VXVLU0ViZFpiZzhraHpj?=
 =?utf-8?B?ZWEvNG5jczFvb3dQMnM4aGxjSElRWW9LUTIxQWM5SjY4K202MktoUGw4aVFN?=
 =?utf-8?B?YlIyb0NPT3BEbWIxc0lVKzhIdURFdVhJRWh6RStWQ3Y5OU0wc1Bud3FFcmds?=
 =?utf-8?Q?Y6wUZ1DKrOWyHEnGONkm3tb072txjF4b1icjg=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121cccf4-26e4-42d3-0902-08dbfb145bf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 13:15:06.3207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a1QpnAno4+1/h7T3h/18MYaQv90wl1CK5nUXmTtZmm9nuIlwmRALLLxUHXGgbGAutuKndLkzcyCFHyvbF1ZA5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8922
X-Proofpoint-GUID: Q__JiI6pMgAqccmrU7Sk8YQfxAeVuXYq
X-Proofpoint-ORIG-GUID: Q__JiI6pMgAqccmrU7Sk8YQfxAeVuXYq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120103
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmlhbmdmZW5nIE1hDQo+
IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDEyLCAyMDIzIDY6NTEgUE0NCj4gVG86IFNlcmdlIFNl
bWluIDxmYW5jZXIubGFuY2VyQGdtYWlsLmNvbT47IE1heGltZSBDaGV2YWxsaWVyIDxtYXhpbWUu
Y2hldmFsbGllckBib290bGluLmNvbT4NCj4gQ2M6IEFsZXhhbmRyZSBUb3JndWUgPGFsZXhhbmRy
ZS50b3JndWVAZm9zcy5zdC5jb20+OyBKb3NlIEFicmV1IDxqb2FicmV1QHN5bm9wc3lzLmNvbT47
IERhdmlkDQo+IFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldCA8
ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtpY2luc2tpDQo+IDxrdWJhQGtlcm5lbC5vcmc+
OyBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBNYXhpbWUgQ29xdWVsaW4NCj4gPG1j
b3F1ZWxpbi5zdG0zMkBnbWFpbC5jb20+OyBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+
OyBBbmRyZXcgSGFsYW5leQ0KPiA8YWhhbGFuZXlAcmVkaGF0LmNvbT47IEJhcnRvc3ogR29sYXN6
ZXdza2kgPGJhcnRvc3ouZ29sYXN6ZXdza2lAbGluYXJvLm9yZz47IFNoZW53ZWkgV2FuZw0KPiA8
c2hlbndlaS53YW5nQG54cC5jb20+OyBKb2hhbm5lcyBaaW5rIDxqLnppbmtAcGVuZ3V0cm9uaXgu
ZGU+OyBSdXNzZWxsIEtpbmcgKE9yYWNsZQ0KPiA8cm1rK2tlcm5lbEBhcm1saW51eC5vcmcudWs+
OyBKb2NoZW4gSGVubmViZXJnIDxqaEBoZW5uZWJlcmctc3lzdGVtZGVzaWduLmNvbT47IG9wZW4N
Cj4gbGlzdDpTVE1NQUMgRVRIRVJORVQgRFJJVkVSIDxuZXRkZXZAdmdlci5rZXJuZWwub3JnPjsg
bW9kZXJhdGVkIGxpc3Q6QVJNL1NUTTMyDQo+IEFSQ0hJVEVDVFVSRSA8bGludXgtc3RtMzJAc3Qt
bWQtbWFpbG1hbi5zdG9ybXJlcGx5LmNvbT47IG1vZGVyYXRlZCBsaXN0OkFSTS9TVE0zMg0KPiBB
UkNISVRFQ1RVUkUgPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IG9wZW4g
bGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47DQo+IEphbWVzIExpIDxsaWphbWVz
QHN5bm9wc3lzLmNvbT47IE1hcnRpbiBNY0tlbm55IDxtbWNrZW5ueUBzeW5vcHN5cy5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG5ldDpzdG1tYWM6c3RtbWFjX3BsYXRmb3JtOkFkZCBzbnBz
LHhwY3MgZGV2aWNldHJlZSBwYXJzaW5nDQo+IA0KU29ycnkgZm9yIHRoZSBwcm9ibGVtIHdpdGgg
bXkgbWFpbCBzZXR0aW5ncy4NCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
PiBGcm9tOiBTZXJnZSBTZW1pbiA8ZmFuY2VyLmxhbmNlckBnbWFpbC5jb20+DQo+ID4gU2VudDog
RnJpZGF5LCBEZWNlbWJlciA4LCAyMDIzIDEwOjI4IFBNDQo+ID4gVG86IE1heGltZSBDaGV2YWxs
aWVyIDxtYXhpbWUuY2hldmFsbGllckBib290bGluLmNvbT47IEppYW5nZmVuZyBNYQ0KPiA8amlh
bWFAc3lub3BzeXMuY29tPg0KPiA+IENjOiBKaWFuZ2ZlbmcgTWEgPGppYW1hQHN5bm9wc3lzLmNv
bT47IEFsZXhhbmRyZSBUb3JndWUgPGFsZXhhbmRyZS50b3JndWVAZm9zcy5zdC5jb20+Ow0KPiBK
b3NlDQo+ID4gQWJyZXUgPGpvYWJyZXVAc3lub3BzeXMuY29tPjsgRGF2aWQgUy4gTWlsbGVyIDxk
YXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0DQo+ID4gPGVkdW1hemV0QGdvb2dsZS5j
b20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkgPHBhYmVu
aUByZWRoYXQuY29tPjsNCj4gPiBNYXhpbWUgQ29xdWVsaW4gPG1jb3F1ZWxpbi5zdG0zMkBnbWFp
bC5jb20+OyBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+OyBBbmRyZXcNCj4gPiBIYWxh
bmV5IDxhaGFsYW5leUByZWRoYXQuY29tPjsgQmFydG9zeiBHb2xhc3pld3NraSA8YmFydG9zei5n
b2xhc3pld3NraUBsaW5hcm8ub3JnPjsgU2hlbndlaQ0KPiA+IFdhbmcgPHNoZW53ZWkud2FuZ0Bu
eHAuY29tPjsgSm9oYW5uZXMgWmluayA8ai56aW5rQHBlbmd1dHJvbml4LmRlPjsgUnVzc2VsbCBL
aW5nIChPcmFjbGUNCj4gPiA8cm1rK2tlcm5lbEBhcm1saW51eC5vcmcudWs+OyBKb2NoZW4gSGVu
bmViZXJnIDxqaEBoZW5uZWJlcmctc3lzdGVtZGVzaWduLmNvbT47IG9wZW4NCj4gPiBsaXN0OlNU
TU1BQyBFVEhFUk5FVCBEUklWRVIgPG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+OyBtb2RlcmF0ZWQg
bGlzdDpBUk0vU1RNMzINCj4gPiBBUkNISVRFQ1RVUkUgPGxpbnV4LXN0bTMyQHN0LW1kLW1haWxt
YW4uc3Rvcm1yZXBseS5jb20+OyBtb2RlcmF0ZWQgbGlzdDpBUk0vU1RNMzINCj4gPiBBUkNISVRF
Q1RVUkUgPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IG9wZW4gbGlzdCA8
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47DQo+IEphbWVzDQo+ID4gTGkgPGxpamFtZXNA
c3lub3BzeXMuY29tPjsgTWFydGluIE1jS2VubnkgPG1tY2tlbm55QHN5bm9wc3lzLmNvbT4NCj4g
PiBTdWJqZWN0OiAgUmU6IFtQQVRDSF0gbmV0OnN0bW1hYzpzdG1tYWNfcGxhdGZvcm06QWRkIHNu
cHMseHBjcyBkZXZpY2V0cmVlIHBhcnNpbmcNCj4gPg0KPiBIaSBNYXhpbWUsIFNlcmdlDQo+IFRo
YW5rcyBmb3IgeW91ciByZXZpZXchDQo+IA0KPiA+IEhpIE1heGltZSwgSmlhbmdmZW5nDQo+ID4N
Cj4gPiBPbiBGcmksIERlYyAwOCwgMjAyMyBhdCAwOToxNDowOEFNICswMTAwLCBNYXhpbWUgQ2hl
dmFsbGllciB3cm90ZToNCj4gPiA+IEhlbGxvLA0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgOCBEZWMg
MjAyMyAwNzowMjoxOSArMDAwMA0KPiA+ID4gSmlhbmdmZW5nIE1hIDxKaWFuZ2ZlbmcuTWFAc3lu
b3BzeXMuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiA+IEluIG9yZGVyIHRvIHNldHVwIHhwY3Ms
IGhhc194cGNzIG11c3QgYmUgc2V0IHRvIGEgbm9uLXplcm8gdmFsdWUuDQo+ID4gPiA+IEFkZCBu
ZXcgb3B0aW9uYWwgZGV2aWNldHJlZSBwcm9wZXJ0aWVzIHJlcHJlc2VudGluZyB0aGlzLg0KPiA+
ID4gPg0KPiA+ID4gPiBJZiBoYXNfeHBjcyBpcyBzZXQgdG8gdHJ1ZSwgdGhlbiB4cGNzX2FuX2lu
YmFuZCBzaG91bGQgcHJlZmVyYWJseSBiZQ0KPiA+ID4gPiBjb25zaXN0ZW50IHdpdGggaXQsIE90
aGVyd2lzZSwgc29tZSBlcnJvcnMgbWF5IG9jY3VyIHdoZW4gc3RhcnRpbmcNCj4gPiA+ID4gdGhl
IG5ldHdvcmssIEZvciBleGFtcGxlLCB0aGUgcGh5IGludGVyZmFjZSB0aGF0IHhwY3MgYWxyZWFk
eSBzdXBwb3J0cywNCj4gPiA+ID4gYnV0IGxpbmsgdXAgZmFpbHMuDQo+ID4gPg0KPiA+ID4gQ2Fu
IHlvdSBlbGFib3JhdGUgb24gd2h5IHlvdSBuZWVkIHRoaXMsIGFuZCBvbiB3aGljaCBwbGF0Zm9y
bQ0KPiA+ID4gZXNwZWNpYWxseSA/IFVzdWFsbHkgZHJpdmVycyBmb3IgdGhlIHZhcmlvdXMgc3Rt
bWFjIHZhcmlhbnRzIGtub3cgaWYNCj4gPiA+IHRoZXkgaGF2ZSBYUENTIG9yIG5vdCwgb3IgY2Fu
IGd1ZXNzIGl0IGJhc2VkIG9uIHNvbWUgaW5mbyBzdWNoIGFzIHRoZQ0KPiA+ID4gY29uZmlndXJl
ZCBQSFkgbW9kZSAoZHdtYWMtaW50ZWwpLg0KPiANCj4gVGhlcmUgaXMgbm8gc3BlY2lmaWMgcGxh
dGZvcm0gaGVyZS4gSSB1dGlsaXplIHRoZSBkd21jYWMtZ2VuZXJpYyBwbGF0Zm9ybSwNCj4gYW5k
IHhwY3MgaXMgdXRpbGl6ZWQgYXMgdGhlIE1ESU8gZGV2aWNlIG9yIGl0IGNhbiBiZSBzZWVuIGFz
IGEgQzQ1IFBIWS4NCj4gV2hpbGUgaXQncyBzb21ldGltZXMgcG9zc2libGUgdG8gZGVkdWNlIHRo
ZSBwcmVzZW5jZSBvZiB4cGNzIGJhc2VkIG9uIGluZm9ybWF0aW9uDQo+IHN1Y2ggYXMgdGhlIHBo
eSBtb2RlIChkd21hYy1pbnRlbCksIHRoaXMgaXMgbm90IGFsd2F5cyBhIGRlZmluaXRpdmUgaW5k
aWNhdG9yLg0KPiBGb3IgaW5zdGFuY2UsIHRoZSBzdXBwb3J0IG9mIFNHTUlJIGJ5IFhQQ1MgZG9l
c24ndCBpbXBseQ0KPiB0aGF0IGFsbCBTR01JSS1zdXBwb3J0aW5nIFBIWXMgaW5jbHVkZSBYUENT
LiBCdXQgYXMgU2VyZ2UgbWVudGlvbmVkLCB1c2luZyBwY3MtaGFuZGxlLA0KPiBvciBwY3MtaGFu
ZGxlLW5hbWUgbWlnaHQgYmUgYSBtb3JlIGVmZmVjdGl2ZSBhcHByb2FjaC4NCj4gPiA+DQo+ID4g
PiBCZXNpZGVzIHRoYXQsIHRoZXJlIGFyZSBhIGZldyBpc3N1ZXMgd2l0aCB5b3VyIHN1Ym1pc3Np
b24uIElmIERUIGlzIHRoZQ0KPiA+ID4gd2F5IHRvIGdvIChhbmQgSSBkb24ndCBzYXkgaXQgaXMp
LCB5b3Ugd291bGQgYWxzbyBuZWVkIHRvIHVwZGF0ZSB0aGUNCj4gPiA+IGJpbmRpbmdzIHRvIGRv
Y3VtZW50IHRoYXQgcHJvcGVydHkuDQo+ID4gPg0KPiA+ID4gPiBUaGUgdHlwZXMgb2YgaGFzX3hw
Y3MgYW5kIHhwY3NfYW5faW5iYW5kIGFyZSB1bnNpZ25lZCBpbnQsDQo+ID4gPiA+IGFuZCBnZW5l
cmFsbHkgdXNlZCBhcyBmbGFncy4gU28gaXQgbWF5IGJlIG1vcmUgcmVhc29uYWJsZSB0byBzZXQg
dGhlbSB0bw0KPiA+ID4gPiBib29sIHR5cGUuIFRoaXMgY2FuIGFsc28gYmUgY29uZmlybWVkIGZy
b20gdGhlIHR5cGUgb2YgQG92cl9hbl9pbmJhbmQuDQo+ID4gPg0KPiA+ID4gQW5kIHRoaXMgcGFy
dCB3b3VsZCBnbyBpbnRvIGEgc2VwYXJhdGUgcGF0Y2guDQo+IFNvcnJ5IGZvciB0aGlzIGlzc3Vl
LCBJIHdpbGwgY3JlYXRlIHRoZSBwYXRjaCBzZXBhcmF0ZWx5IGxhdGVyLg0KPiA+DQo+ID4gSW4g
YWRkaXRpb24gdG8gd2hhdCBNYXhpbWUgYWxyZWFkeSBzYWlkIGhhdmluZyBEVC1iaW5kaW5ncyBh
ZGp1c3RlZCB0bw0KPiA+IGZpdCB0byB0aGUgcGF0dGVybiBpbXBsZW1lbnRlZCBpbiB0aGUgc29m
dHdhcmUgcGFydCBpcyBhIHdyb25nIHdheSB0bw0KPiA+IGdvLiBUaGUgYmVzdCBjaG9pY2UgaW4g
dGhpcyBjYXNlIGlzIHRvIGFkZCB0aGUgRFcgWFBDUyBEVC1ub2RlIHRvIHRoZQ0KPiA+IERXIE1B
QyBNRElPL01JIGJ1cyBhbmQgdGhlbiB1c2UgdGhlICJwY3MtaGFuZGxlIiB0byBpbmZvcm0gdGhl
IE1BQw0KPiA+IChtYWlubHkgaXQncyBkcml2ZXIpIG9mIHdoYXQgUENTLWRldmljZSBpcyBhY3R1
YWxseSBhdHRhY2hlZCB0byBpdC4NCj4gPiBUaGUgc2VyaWVzIEkgc3VibWl0dGVkIG9uIHRoaXMg
d2VlayBpcyBleGFjdGx5IGFib3V0IHRoYXQ6DQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92
My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDIzMTIwNTEwMzU1OS45NjA1LTEt
DQo+IGZhbmNlci5sYW5jZXJAZw0KPiA+IG1haWwuY29tL19fOyEhQTRGMlI5R19wZyFZNlIzV1pX
SGVCZHJrWmtsYnFyQVFBUmJIblEtDQo+IGdfVGJiNnI1SXFjc1NITVFfbDRyT3pMTGdadkxQbDZZ
UA0KPiA+IEJZZmVyYmpyYmpaQTZfWHZTU1N2a1YzNWVvMmpXUHokDQo+ID4gSSBndWVzcyBJJ2xs
IG5lZWQgYWJvdXQgYSBtb250aCBvciBzbyB0byBzZXR0bGUgYWxsIHRoZSBjb21tZW50cywgYnV0
DQo+ID4gdGhlIHNvbHV0aW9uIGltcGxlbWVudGVkIHRoZXJlIHdpbGwgYmUgYmV0dGVyIHRoYW4g
dGhpcyBvbmUgcmVhbGx5Lg0KPiA+DQo+IFllcywgSSBhZ3JlZSB0aGF0IGJpbmRpbmcgdGhlIHhw
Y3MgdmlhIHRoZSAicGNzLWhhbmRsZSIgRFQgZmlybXdhcmUgbm9kZQ0KPiBpcyBhIGJldHRlciB3
YXkuIGJ1dCB0aGUgY3VycmVudCBtZXRob2Qgb2YgYmluZGluZyB4cGNzIHRocm91Z2ggc2Nhbm5p
bmcNCj4gYWRkcmVzc2VzIHN0aWxsIHJlbGllcyBvbiBtZGlvX2J1c19kYXRhLT5oYXNfeHBjcy4N
Cj4gVGhlIDE2dGggcGF0Y2ggaW4geW91ciBwYXRjaHNldCBhbHNvIG1lbnRpb25zIHRoZSBkaWZm
aWN1bHR5IG9mDQo+IG9idGFpbmluZyBoYXNfeHBjcy4gVGhlcmVmb3JlLCBjYW4gd2UgYWRkIHBh
cnNpbmcgb2YgcGNzLWhhbmRsZS1uYW1lcw0KPiBpbiB0aGUgcGxhdGZvcm0gdG8gZGV0ZXJtaW5l
IGlmIHRoZSB4cGNzIGV4aXN0cywgbGlrZSB0aGlzOg0KPiANCj4gaWYgKHBsYXQtPm1kaW9fYnVz
X2RhdGEpIHsNCj4gCXJjID0gb2ZfcHJvcGVydHlfbWF0Y2hfc3RyaW5nKG5wLCAicGNzLWhhbmRs
ZS1uYW1lcyIsICJkdy14cGNzIik7DQo+IAlpZiAocmMgPj0gMCkgew0KPiAJCXBsYXQtPm1kaW9f
YnVzX2RhdGEtPmhhc194cGNzID0gdHJ1ZTsNCj4gCQlwbGF0LT5tZGlvX2J1c19kYXRhLT54cGNz
X2FuX2luYmFuZCA9IHRydWU7DQo+IAl9DQo+IH0NCj4gDQo+IFRoYW5rcywNCj4gSmlhbmdmZW5n
DQo+IA0KPiA+IC1TZXJnZSh5KQ0KPiA+DQo+ID4gPg0KPiA+ID4gVGhhbmtzLA0KPiA+ID4NCj4g
PiA+IE1heGltZQ0KPiA+ID4NCg==
