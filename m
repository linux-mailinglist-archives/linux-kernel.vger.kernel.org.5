Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2198112C3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378927AbjLMNYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbjLMNYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:24:31 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A005DD;
        Wed, 13 Dec 2023 05:24:32 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=K7KRJ/L+5IOtjATWLw6iI81Gek1yTvYP+keBNEvXyoWzjogP6O+UlPB3yOPN8imVXeunU2O73GXAoutAIlBePnwA9NEOYNqzdJpyziT808nz+PzGqoeOtlZd895Wm1GosBVN4ZVewLJzLpSZjJ5hmQ2xqdXeGAALwTrnCRFXOBG3z+BT2qfXhawSkKwsh4VIpuMiI2bzv49evjJ9Re+tBKDVlmplNvxv4m8dOxuiXSI2EwR9hrqv3zJVBsSfMI9BRlEuyNBi6E2tna93BdMFH83cX7IlBhwrYC9g8moPgeIKTtBkZOdEGAHLs529WfLrp2JYw5AXGov83Nz9+GO/lA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/ahZhasMFCjsidEYDoKhiHGP3QF7UyRz+viRjjYz6k=;
 b=mR1HfnKnr3/czWJxHeO6QuYiGZw0OswybmZW2cnsOBoDW1dlc0CqwxNYv1IhUFycvfLWSEo6uc7S+EW3bbZMw2V3PkVhs3NX5/j08elubtQUxUzF9A1uN5Xh+66KYK2ePUsSo0LXqfg8X9s+bVpkuaSSx1awD8dt0V6bvR0RXn/whea+yjWg6ozfTHOFTiCspll9FpmycX9GFeDQuD+X/x5yfrEXhCZtmr4mnwhZyVnLPwCYwMSgutRA2IaZdClE60dXSryvR7ikKA6/BBXj8dgRhxHsHKGJ1+r9hTULTHGXy7cAar9WXD85A1sQLR3z05ow/SZVLNz0tjTJMzvSig==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=gmail.com smtp.mailfrom=topic.nl;
 dmarc=bestguesspass action=none header.from=topic.nl; dkim=fail (signature
 did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/ahZhasMFCjsidEYDoKhiHGP3QF7UyRz+viRjjYz6k=;
 b=qZK6cyBNPMs+x1flbci7hIn6yvET9okid1EbSbjiTsjK6cYPz66eWZqia6wZd/vaoy/GGEZ7vh5KWcIiSHmBsMBTdSTRpfy0BpC7nydyjKZS+BdN65nR4Q7ddudvQUzQyatlcfRdOFbbCLwp8Lgvf1jkFwf6jBXhKcgV/GPDja/tqViXYn4U6X9MLh08waZDnOYjTEErW+f21OrxoGvChaUUPJJf8nu644d1gmmz1VvuN9GYgZYvn1eZMtgkc5UAU5g9jfmvlYf6YF0Ttkf06vIJ+IrdAE4Z4CXvDRvtfsvvVeaOKNl6Ou4/OruPliTOgam+mNnmx2jjWXwaHabXgQ==
Received: from DUZP191CA0051.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::28)
 by VI1PR04MB9930.eurprd04.prod.outlook.com (2603:10a6:800:1e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 13:24:28 +0000
Received: from DB5EUR01FT061.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:4fa:cafe::59) by DUZP191CA0051.outlook.office365.com
 (2603:10a6:10:4fa::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 13:24:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=bestguesspass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB5EUR01FT061.mail.protection.outlook.com (10.152.5.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.25 via Frontend Transport; Wed, 13 Dec 2023 13:24:27 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.168) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 13 Dec 2023 13:24:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVgNIsLmWmB2QNkaE4C0WvjN7REaqjGWGXk08HkZ+QB8iR1p4WurPLDrqF7JyToG6M1vAihx/owCTkBb1nm7DdAB/B5MpAi01QUKIrXkz2W9KeRdKYjTUt4jChI/0kWs7qUPZH/Lkgs+11wkfSkSELB93uq5KM8YUmV1Qven77A0sz+w2F4FpyI3+4xP2AKDblUbZ6CZ+dO6CtkcFxLuzxH5qFDwqfnmEg2P4Tqv6SNNV3koM+mJVLu4I8ZmeyoT9O8Sjh3xbjm9x/k/5wICawJC10hesY7Dzt9ARussV/UctqaIezw1dnqevp98MN1UE8Xox9zC0j8iAtkWTnc/lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s08nEyhTwY+SnX7FSB/SjXzbEceymFZExSU7e3477yo=;
 b=A7wf5LXfjxdvCyWxxZm1kqHsDT0yHIMqHJJoWuOMCKMx7iyLIILm96Nxaiaf/OAwOfaUzPy/ArnR6q/A0WkpUXITtRS0zLNDKgYswXNgSpid05lCiRdvDcm9Ca+Lt/Bm9pK8+ln1YEYEjzczOa2CYkM+LoxNYtLAocZR0uf1QfWgCVPpbXoP4QM02BaNO1TQJ0mUFogj+VMmbHd3RC4umh+eeg/+dYg3Um5lWbsEXUr1dQdog/jVhB9jQ0+sHUFQm7DcUUftejk3rrQome19KyLGPAkslF9qLcg88S8pGZJ5Z2ZCUjhC+aHEVuwmPovLOX07SrpQ7G1b5EPV2X9u9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s08nEyhTwY+SnX7FSB/SjXzbEceymFZExSU7e3477yo=;
 b=Dmt1u8ZT7MkhScSufsXi/nx6gTfPgj7NIGZ8uPyI3L51NxXDB3iaQFBSLlBE2g4/tTHclba48xrEQoDrCQDr7U4lB/XX7+iEkJR7ZgS+qKHzFhG3oRDnF9chQKcZ0KWXWqG2KHT0Q2WAS0txGxIae/ndU8IduLGClfRS1hD4tPY8P5O5qE+MfMP7ef3akvHRXxZI0hvWKQfN4soGsuZmCieIvBZVH5V3CYzhR9O55314LKolewNCNoleywo7vYv1zaZ3LQq5AXJnc1ZgFs3Oy+YmN041sPeJsigIOLP1vRS63+bT+TDkJj77Mzuwq+IgFQj+9z/C5KSO+15u9i7Lkg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VE1PR04MB7471.eurprd04.prod.outlook.com (2603:10a6:800:1a7::11)
 by AM9PR04MB7666.eurprd04.prod.outlook.com (2603:10a6:20b:287::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 13:24:22 +0000
Received: from VE1PR04MB7471.eurprd04.prod.outlook.com
 ([fe80::ec21:cf04:ed05:c7b1]) by VE1PR04MB7471.eurprd04.prod.outlook.com
 ([fe80::ec21:cf04:ed05:c7b1%4]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 13:24:22 +0000
Message-ID: <f9c89cba-ff1f-49f2-b810-061a04b03b40@topic.nl>
Date:   Wed, 13 Dec 2023 14:24:20 +0100
User-Agent: Mozilla Thunderbird
From:   Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH 2/2] iio: spi-dac: Add driver for SPI shift register DACs
To:     =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
CC:     Andrea Collamati <andrea.collamati@gmail.com>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20231213090910.25410-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.23e530d1-f5da-4919-8889-d7109d21097b@emailsignatures365.codetwo.com>
 <20231213090910.25410-2-mike.looijmans@topic.nl>
 <f66628800aa2c5242b3a7783565eb604f52dafa4.camel@gmail.com>
Content-Language: en-US
Organization: Topic
In-Reply-To: <f66628800aa2c5242b3a7783565eb604f52dafa4.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR04CA0038.eurprd04.prod.outlook.com
 (2603:10a6:208:1::15) To VE1PR04MB7471.eurprd04.prod.outlook.com
 (2603:10a6:800:1a7::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VE1PR04MB7471:EE_|AM9PR04MB7666:EE_|DB5EUR01FT061:EE_|VI1PR04MB9930:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e9eed5-aa5b-4664-8a9a-08dbfbded4e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ZqaiSUSDn4IFGaVI9n3Tl4XMDElb/Z911DVaAMQZoLVxB5HbBKTRBGn+Rt+cPvopqFXLaqdjaI8kNszCHqxP5e58l6NKgXg3K6W2P5uAe0J8r88cVZOweWtUUqqkJRJxvB+Y2HahHb+0RXoZqWtfVPCgxqEKeXpJhfG3qa/xIm/kIjaU0k5r5SX8Jv1NrMKrKG12X/4EkRj1Gk4Fek4h19Z22tDK7hUqbmEhXBOrEHfxqbLJn6v26f3HI/uSOJOBDhnX5v6EQ5pcAxu6vpcrY4faCY2mcQv9t3PIAbGJkveE8n01nYt7hi/kiGyl77Rsn0UDSQ+3OeoCgiiYLgYjz+k92Rnaz+DOhzifJBUnTOcsXKfgF38tnoYSZzTlRhMjrMrBVaLjL8yOEWA0k36fhA7sJw73x7pHktCvVr2zzCjhopKF3CKkTxMJZbnu4PXL+oKXCuAHk+DzW6phk1RqBdW7aD0oSv3BIp7TH8zdOMJGnGcU4kSOkbLZeqzU4TknrDeSrdWpA6McTzwdGvGy+dYmuuy5XfrWoOdFOx6FNGbBEN/tvZC1NJJd7ClGxLOZX/nFcY3K3khpqwvfEEZjm8O6k69EUItfyBOKuPRmmdM0XSYgT85jBOruuIbkdYWRhvV/95Nle5Bzx1/Jmv/wlGZBXSTgNGVvJkmeV7Il8SE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7471.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39840400004)(136003)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(41300700001)(26005)(2616005)(83380400001)(36756003)(86362001)(15974865002)(38350700005)(31696002)(38100700002)(5660300002)(4326008)(316002)(44832011)(8676002)(8936002)(53546011)(4001150100001)(7416002)(2906002)(30864003)(6512007)(6506007)(52116002)(36916002)(66946007)(66556008)(66476007)(54906003)(478600001)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7666
X-CodeTwo-MessageID: f9c1cc60-127a-4fdc-83ac-3b26543b46ba.20231213132425@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT061.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8840bab1-1458-4e4e-7320-08dbfbded146
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r6MfYdzpLIaFBnoNiAFfDIq6hMZdLyGeib6CgGX7LvL8aB/34EzcjlC+w0T9Q9JgEGWqirJFZcZ/cSDvtO1SPdd44Sxq22NlEdxppkqbtWJI2Wvd7bRtDfpgK2Q2yduHvqoZXLVZOyxOCiPSq8LSjxk4pSX5X+hke8I6XV83s6UmqZHzu+uc0lnXHgvWmvKeR6LLgN/3yxQcSaV8jqX3GkKJtj91Nc4zhD6dd+ZlqWjC4a9j9QuDk9sSJp4wZzZJd3I29VK0a1htCQjuU+t+xdQp5SWhU9GMq9o9dTscsCmAKmDg8VaTTPA+D1Nhg7KBd7DOgEB7lkAGy96//Q/oZN4bvpCyV7+fDi9+h32iXxyeSKqAdJTKuhlheqP5cZCuTD5mDCqi6YycUNim92hTYP95TWVEcbkeUavA/+//xMbzTwyt66lYHBYZ7RYexCfmJEOQyP/YwtYWPgC/emwIETYAF33sv864SjG3QYH4YlcZF/w6HCcZHwMQpm1ngGFX5QnPVaqsiLTH4lf2XC/RxNBgIKkdSdFdCAOVJDLHkfWPp+Zsc+W69jLtUk2qAByMT16HHX5B4mt7b244gAGLw1Gi5WfsR+q/5DFv7s2ZHoSW4wsYZJ7/x8Il4NfrXsoR6P7CIi83qAvZkTZRvtxZyHk/aQQvtHKWzymAPZ2w/FTXcdj4cbOJfzp9pedepkyA+xkyxQ23u/NM1iGjJpjc1KbbFMXa1PlJhsNaYLPa3mk5IVtRPs+t+ou8KXmUUliw
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39830400003)(230922051799003)(186009)(451199024)(1800799012)(82310400011)(64100799003)(46966006)(36840700001)(83380400001)(47076005)(7636003)(26005)(336012)(356005)(7596003)(5660300002)(36860700001)(44832011)(8936002)(316002)(54906003)(8676002)(2906002)(7416002)(4001150100001)(30864003)(4326008)(478600001)(53546011)(41300700001)(6512007)(36916002)(6506007)(70586007)(6486002)(70206006)(2616005)(36756003)(86362001)(15974865002)(31696002)(40480700001)(31686004)(43740500002)(18886075002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 13:24:27.2628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e9eed5-aa5b-4664-8a9a-08dbfbded4e8
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT061.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9930
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nuno,

Thanks for reviewing,

See below...

On 13-12-2023 11:37, Nuno S=C3=A1 wrote:
> Hi Mike,
>
> Some comments from me...
>
> On Wed, 2023-12-13 at 10:09 +0100, Mike Looijmans wrote:
>> Add a driver for generic serial shift register DACs like TI DAC714.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>
>> ---
>>
>>  =C2=A0drivers/iio/dac/Kconfig=C2=A0=C2=A0 |=C2=A0 11 ++
>>  =C2=A0drivers/iio/dac/Makefile=C2=A0 |=C2=A0=C2=A0 1 +
>>  =C2=A0drivers/iio/dac/spi-dac.c | 212 +++++++++++++++++++++++++++++++++=
+++++
>>  =C2=A03 files changed, 224 insertions(+)
>>  =C2=A0create mode 100644 drivers/iio/dac/spi-dac.c
>>
>> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
>> index 93b8be183de6..bb35d901ee57 100644
>> --- a/drivers/iio/dac/Kconfig
>> +++ b/drivers/iio/dac/Kconfig
>> @@ -410,6 +410,17 @@ config MCP4922
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To compile this =
driver as a module, choose M here: the module
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 will be called m=
cp4922.
>>  =20
>> +config SPI_DAC
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate "SPI shift register =
DAC driver"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on SPI
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Driver for an array of=
 shift-register DACs, like the TI DAC714.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The driver shifts the =
DAC values into the registers in a SPI
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 transfer, then optiona=
lly toggles a GPIO to latch the values.
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To compile this driver=
 as a module, choose M here: the module
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 will be called spi-dac=
.
>> +
>>  =C2=A0config STM32_DAC
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate "STMicroelectr=
onics STM32 DAC"
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on (ARCH_STM32 =
&& OF) || COMPILE_TEST
>> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
>> index 5b2bac900d5a..33748799b0f0 100644
>> --- a/drivers/iio/dac/Makefile
>> +++ b/drivers/iio/dac/Makefile
>> @@ -45,6 +45,7 @@ obj-$(CONFIG_MCP4728) +=3D mcp4728.o
>>  =C2=A0obj-$(CONFIG_MCP4922) +=3D mcp4922.o
>>  =C2=A0obj-$(CONFIG_STM32_DAC_CORE) +=3D stm32-dac-core.o
>>  =C2=A0obj-$(CONFIG_STM32_DAC) +=3D stm32-dac.o
>> +obj-$(CONFIG_SPI_DAC) +=3D spi-dac.o
>>  =C2=A0obj-$(CONFIG_TI_DAC082S085) +=3D ti-dac082s085.o
>>  =C2=A0obj-$(CONFIG_TI_DAC5571) +=3D ti-dac5571.o
>>  =C2=A0obj-$(CONFIG_TI_DAC7311) +=3D ti-dac7311.o
>> diff --git a/drivers/iio/dac/spi-dac.c b/drivers/iio/dac/spi-dac.c
>> new file mode 100644
>> index 000000000000..0c0113d51604
>> --- /dev/null
>> +++ b/drivers/iio/dac/spi-dac.c
>> @@ -0,0 +1,212 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * SPI generic shift register Serial input Digital-to-Analog Converter
>> + * For example, TI DAC714
>> + *
>> + * Copyright 2023 Topic Embedded Systems
>> + */
>> +#include <linux/delay.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/iio/iio.h>
>> +
>> +struct spidac {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct spi_device *spi;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct gpio_desc *loaddacs;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 *data; /* SPI buffer */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 data_size;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Protect the data buffer an=
d update sequence */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mutex lock;
>> +};
>> +
>> +static int spidac_cmd_single(struct spidac *priv,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan, int val)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 *data =3D priv->data + cha=
n->address;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int bytes =3D chan->=
scan_type.storagebits >> 3;
> the '3' seems a bit "magical". Is the intent diving by 8? I would say so =
and if it
> is, doing the explicit division would be more readable IMO.

Divide by 8 is indeed the intention (bits to bytes). But... if=20
storagebits cannot be 24 for example, it'll have to be stored elsewhere=20
anyway.


>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int i;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Write big-endian value int=
o data */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data +=3D bytes - 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < bytes; i++,=
 val >>=3D 8, data--)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0*data =3D val & 0xff;
> This not optimal... You allow someone to put in any 'bits_per_channel' fr=
om FW. In
> theory, one could set, let's say 64bits but then you only allow an intege=
r value. So,
> we need to make things more sane.

I think limiting to 32 bit is sensible enough (a 64-bit DAC would be=20
moving individual electrons around or so), but that should indeed be=20
made explicit.


> With some rework, I think we can also make use of put_unalignedX()...

Agree. Might want to make endianness a configuration option as well=20
(haven't seen a little-endian device though).


>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D spi_write(priv->spi, =
priv->data, priv->data_size);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ret;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gpiod_set_value(priv->loaddac=
s, 1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0udelay(1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gpiod_set_value(priv->loaddac=
s, 0);
>> +
> Can't we sleep in here?

indeed, should have used _can_sleep variants (spi_write needs to sleep=20
anyway).

Probably left over from my thought of doing it in the SPI completion=20
callback.


>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
>> +}
>> +
>> +static int spidac_decode(struct spidac *priv, const struct iio_chan_spe=
c *chan)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 *data =3D priv->data + cha=
n->address;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int bytes =3D chan->=
scan_type.storagebits >> 3;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int i;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int val =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Read big-endian value from=
 data */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < bytes; i++,=
 data++)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0val =3D (val << 8) | *data;
>> +
> Again, with some refactor I think we can make use of get_unalignedX()...
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return val;
>> +}
>> +
>> +static int spidac_read_raw(struct iio_dev *iio_dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 const struct iio_chan_spec *chan,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 int *val, int *val2, long mask)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct spidac *priv;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0switch (mask) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case IIO_CHAN_INFO_RAW:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0priv =3D iio_priv(iio_dev);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0mutex_lock(&priv->lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0*val =3D spidac_decode(priv, chan);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&priv->lock);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return IIO_VAL_INT;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case IIO_CHAN_INFO_SCALE:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0*val =3D 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return IIO_VAL_INT;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> +}
>> +
>> +static int spidac_write_raw(struct iio_dev *iio_dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 int val, int val2, long mask)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct spidac *priv =3D iio_p=
riv(iio_dev);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (mask !=3D IIO_CHAN_INFO_R=
AW)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
>> +
> nit: I would still keep the switch(). Consistency with read_raw().
Agree
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&priv->lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D spidac_cmd_single(pri=
v, chan, val);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&priv->lock);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
>> +}
>> +
>> +static const struct iio_info spidac_info =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.read_raw =3D spidac_read_raw=
,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.write_raw =3D spidac_write_r=
aw,
>> +};
>> +
>> +static int spidac_probe(struct spi_device *spi)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_dev *iio_dev;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct spidac *priv;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_chan_spec *channel=
s;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct gpio_desc *reset_gpio;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 num_channels;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 bits_per_channel;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 bytes_per_channel;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 i;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_dev =3D devm_iio_device_a=
lloc(&spi->dev, sizeof(*priv));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!iio_dev)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -ENOMEM;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0priv =3D iio_priv(iio_dev);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0priv->loaddacs =3D devm_gpiod=
_get_optional(&spi->dev, "ldac",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GPIOD_OUT_L=
OW);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(priv->loaddacs))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return PTR_ERR(priv->loaddacs);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reset_gpio =3D devm_gpiod_get=
_optional(&spi->dev, "reset",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GPIOD_OUT_HIGH);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(reset_gpio))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return PTR_ERR(reset_gpio);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0priv->spi =3D spi;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spi_set_drvdata(spi, iio_dev)=
;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0num_channels =3D 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bits_per_channel =3D 16;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0device_property_read_u32(&spi=
->dev, "num-channels", &num_channels);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0device_property_read_u32(&spi=
->dev, "bits-per-channel",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &bits_per_channel);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bytes_per_channel =3D DIV_ROU=
ND_UP(bits_per_channel, 8);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0channels =3D devm_kcalloc(&sp=
i->dev, num_channels, sizeof(*channels),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GFP_KERNEL);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!channels)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -ENOMEM;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0priv->data_size =3D num_chann=
els * bytes_per_channel;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0priv->data =3D devm_kzalloc(&=
spi->dev, priv->data_size,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL | GFP_DMA);
> GFP_DMA? This is rather unusual... And if you look at the description of =
it, does not
> look like a good idea to use it. Also, consider devm_kcalloc()

The "data" buffer is to be passed to SPI controller and must be DMA=20
capable. Hence the GFP_DMA.

Feels oldskool to me as well, but could not come up with a better=20
solution...

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!priv->data)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -ENOMEM;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < num_channel=
s; i++) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0struct iio_chan_spec *chan =3D &channels[i];
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0chan->type =3D IIO_VOLTAGE;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0chan->indexed =3D 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0chan->output =3D 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0chan->channel =3D i;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0chan->address =3D i * bytes_per_channel;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0chan->info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0chan->info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SC=
ALE);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0chan->scan_type.sign =3D 's';
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0chan->scan_type.realbits =3D bits_per_channel;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0chan->scan_type.storagebits =3D bits_per_channel;
> Hmm does no look right. You pretty much allow any value from FW and I'm f=
airly sure
> that 'storagebits' have to be the size of a C data type as we want elemen=
ts to be
> naturally aligned when buffering for example. I'm seeing you're not using=
 buffering
> but still... Is really any arbitrary value what we want here?

Found out the hard way (while writing ads1298 driver) that this is=20
indeed the case, IIO cannot handle 24-bit buffers for example. This=20
driver doesn't support any buffering though.

So indeed, I'll have to separate things. This will also affect DT bindings.

How many bytes per sample to be sent on the SPI bus, and how many bits=20
actually mean anything. For example, 2 bytes per sample and 14-bit=20
resolution.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_dev->info =3D &spidac_inf=
o;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_dev->modes =3D INDIO_DIRE=
CT_MODE;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_dev->channels =3D channel=
s;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_dev->num_channels =3D num=
_channels;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_dev->name =3D spi_get_dev=
ice_id(spi)->name;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_init(&priv->lock);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (reset_gpio) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0udelay(1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0gpiod_set_value(reset_gpio, 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> +
> I would place devm_gpiod_get_optional() close to the place of the reset..=
. Also, any
> strong reason for udelay()? Consider fsleep() instead.

That, and can_sleep.


>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return devm_iio_device_regist=
er(&spi->dev, iio_dev);
>> +}
>> +
>> +static const struct spi_device_id spidac_id[] =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{"spi-dac"},
> no ti,dac714?

That, and I've been wondering if this table is needed at all?


>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{}
>> +};
>> +MODULE_DEVICE_TABLE(spi, spidac_id);
>> +
>> +static const struct of_device_id spidac_of_match[] =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "spi-dac" }=
,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "ti,dac714"=
 },
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, spidac_of_match);
>> +
>> +static struct spi_driver spidac_driver =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.driver =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "spi-dac",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .of_match_table =3D spidac_of_match,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> indentation...
>
> - Nuno S=C3=A1
>

--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl



