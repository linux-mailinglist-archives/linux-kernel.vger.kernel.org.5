Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB8C8076AA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378566AbjLFReU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378537AbjLFReT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:34:19 -0500
X-Greylist: delayed 667 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Dec 2023 09:34:21 PST
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78E6D51
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:34:21 -0800 (PST)
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.9.37])
        by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 297BC10B6FB72
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:23:15 +0000 (UTC)
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.179.251])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id DAC72100004E9;
        Wed,  6 Dec 2023 17:23:11 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1701883391.559000
X-TM-MAIL-UUID: 4d506196-66da-49a0-8eaa-adebe54fe412
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 88A8F10000312;
        Wed,  6 Dec 2023 17:23:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaVd5hK7ne7111VGrUVpXtve9gy4CfWvah8RzjT10lQl/KCaLlbTzlTfChequcbsYAjWW738S2Q9Tlsxc92u2qiWdaE6MYxnoPQZ5oWYql+19Cqr6G8C677zs2MecmN4EtRxHIYjsX1fW6h4y9VLHMt+jcuB2XPGqe6NYPPfFqEq0VOaAcRmYp7dggqNfjSIVwW6+BzFAxT8Ann4bdAsJ59QcoR96uxpZIi37yHlWW1hrPjjJ2vwFPZmb2RmCg4nsNpCaJkCaAvrXH1Hn9QaiG66vhiZ33xEftAga0LYgdmLFFczMhRy1D9XIvmk7sQ1eQ9flszr7G/qhd4p6YGLoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CX2lqi4XghnX4++871xLu3BO0SndIcAeIg33HcF+3jg=;
 b=CtrR9U+P2H3juxG0Z9TEkj1ZQFBbpC5Wv2fgm2we+4ZPIsn4/U7pNE1gJnruaBU2gmgA7VaUFmfUjhi/jvM3wl9kn5RJPIgUsMuYtT+FwidqO2kx3cs06FyUqcUYFoTO1zPg1DzxLA2lIrwTq37Zw0DeohgGiOyRa1OIo4ii4v/JUywcq7F3draMZ8fiFTaQUvlOTQMOzgsb09w3o/ji/gGVQykpAZ6TaXmqJ3L/YMvDiWTKk4WZ3+SRnFx7032WUIW7dhNNCbQ3O/fK7o/OBLGtXrdffJfnWlvhMXbsrj0JU5GIP0rV2ueFsVkyLUjws8rWyMFYC2ZQwhrVK8+/ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <75e473b2-f4d2-476c-8d1c-1085446d8b41@opensynergy.com>
Date:   Wed, 6 Dec 2023 18:23:08 +0100
Subject: Re: [RFC PATCH v1 3/3] SPI: Add virtio SPI driver (V4 draft
 specification).
To:     Mark Brown <broonie@kernel.org>
Cc:     virtio-dev@lists.oasis-open.org,
        Haixu Cui <quic_haixcui@quicinc.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harald.Mommer@gmail.com, quic_ztu@quicinc.com,
        Matti Moell <Matti.Moell@opensynergy.com>,
        Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
References: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
 <20231027161016.26625-4-Harald.Mommer@opensynergy.com>
 <ZUjuxfKdwRQgbfdb@finisterre.sirena.org.uk>
Content-Language: en-US
From:   Harald Mommer <harald.mommer@opensynergy.com>
In-Reply-To: <ZUjuxfKdwRQgbfdb@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::20) To BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB3400:EE_|FR0P281MB2121:EE_
X-MS-Office365-Filtering-Correlation-Id: 3363d888-cebe-4d2d-ac60-08dbf68004b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jCaIzUt+huhZPMwWvlDmfXwwRTy5bnZp7QkS4xFYkbs0UpPLV/yj+1IuMg6bahx4GsDwCDqj+cqjYlP5x0diC4AF4Ro7ZqYO3+4sn7JLqeSUEIt2Hwq66DN50g/FaYteL0s6ejQ1rmyRGnfNpe9Zx0jm0Pc9vobR2hq53tz3bmejER3Incxo1gpSCX3CzYPXp9t5h3ZB0LpkwyseyWPfGiB4hq7BQk7WyvKYux9J0V9uZItMw8dpGzJi942kCKcbNyWaASHMZHRml8tlr2aShbJx/uGatruNPkoFMwcHZg9vnGlq6zO/2+egocMXQw7TzWfjHZNpFuSugV+IRHJd2H1KEQ6xsEbaH7RKZo9IrkPzr+U4mk8QvXru3spVFYKunoeoe99IXcf1WPh23GfGtFD48U6mAbFNb8hwJtKO55eadYXhx8QDKjlStzh2Z7lrj/0Vw9Robox9adL3LlLYnEWYS34Va9sDaPoJnROm1mE9T/GSsTKS/99uwH/ptGRRVyBqgnYYDd4+lupslipURB1VikYZsoQdc4JuU5NU4QZTPONY3ab0XfEOmqMqq/OyRnAmuXKipfvvHmoNr2PWJN+q1/JWrDDj2pbGw3tkLVI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39840400004)(366004)(136003)(376002)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2906002)(5660300002)(8676002)(38100700002)(36756003)(41300700001)(44832011)(31686004)(86362001)(4326008)(8936002)(316002)(66556008)(6916009)(54906003)(66946007)(66476007)(42186006)(478600001)(31696002)(83380400001)(26005)(53546011)(107886003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEVOaXJYb1VEZFUzbVN6dTRiZ3BNaTYxS0hROHVpKzB6SWxZcnExNG9wZkRi?=
 =?utf-8?B?cWQyWlg4dGtJSFBnNGRzc215TGswWGRiam5KNTZ2TWxhYkVzeGRCeEZkcXcx?=
 =?utf-8?B?L2xTSUp3TEM4N2kwdzh3SDZwcjh6bUpmTURjb2phK003QXdLR3p5UXZ5UzJj?=
 =?utf-8?B?TFV1ZEl6SFgxTlVFQ0tnMEsza2d1SnFXMmNDWHRMU2NKREQxdnp3cVI0Y3lM?=
 =?utf-8?B?RjdGSyt0cDZNRThVaDZWYlNLTm1rdWxJdEdDU2RkSndLMitEWWVYVGtEa1dk?=
 =?utf-8?B?b3BuWXZjQTcvZTR2NDZmL2ppSHNhUUxRMys1a0xMT1lWTVErWmFySEJhNXRx?=
 =?utf-8?B?NkI0bmxVQWtYZWRrYnZDSk16MlMyeUd5MzY5SjNUN3cyeERmODZrdGZMWmt5?=
 =?utf-8?B?RXR4MThrK1UveGJEMWFpTGxlZ0EzbzF1dHQzSmwwSXhKdGNiOGFnaENyclk3?=
 =?utf-8?B?TWlobVo4OHpzU0V5dVZINlVWNVZjTmJ6ZTNFd2VnbDFTNHBXRmVmNHdPcmlj?=
 =?utf-8?B?MlBvQUV6a0xVRUVHV1dldW9SSHlDaEY1V2dzSXREenpVTEgwTFhHbm1kUWls?=
 =?utf-8?B?R1JXMjNZSEtuK1hQeW0yTUZZb1pIcXppYmZHWGVkem9zK1NKTExBdHBQaTVL?=
 =?utf-8?B?TkVYczV5SCs3cGhhSkVyc1lEc0VBbWJsL0YxM3JUWHhpVWRPbjZPLzdaaWhP?=
 =?utf-8?B?cGRnb0hFMjMvbFozZmNvaFN5TllIR2pDZGFZbWk2bEg0OVo1LzZOVzkzQnBr?=
 =?utf-8?B?cEtxbmhQeXlXNnFRVG9xd3JmR0ZIMHRhaDRVU3hnd3pzZHVTendZNmtOUng1?=
 =?utf-8?B?Sjl2dVlNVFA0RGZadGsxcTgyUFhlaWtOMWt1a0RlbEg0Wm1QN0ZYdnhMcE1o?=
 =?utf-8?B?aXBIc3hKSEkrd3Nyb0haSXNXQ09LTFdYNXJ1Umtmak11MlZSamM2Wlp5OEdi?=
 =?utf-8?B?cVR2NEVPM1UvMlVpL3JybFU0YkFsYW5DbDlwTFFPdUtrZUROTEx6bUg1aHE0?=
 =?utf-8?B?amlsMW1kK2Y3VUdWTk9UbnBMT3Z6TEZOMit5MmdVVWxjdnBvaW4vVUQ3Tzli?=
 =?utf-8?B?R0tNbGcwNnFNalFObmJ5UDlJL3AwYmwrQTVoelZJSnk1aDlFdnRZY2h4OWls?=
 =?utf-8?B?ci84UTB4c0wvbEd5RDEvb2J2YzJyaFl4bmE3QXJ6djRpeUIwVFdaQmRsWURM?=
 =?utf-8?B?RElMUGpScy93S3dsVXI4VEoybHlwaDFUMlYxdWtYWFdMdWxhSHhuUk9lbHZI?=
 =?utf-8?B?cGxYMVVFTXEyM3ZZYWZZSnZhbklwMDRNOFlMc3g0cXdsY3JSNzUvcy91bE91?=
 =?utf-8?B?aTIyQzRLSkdvZSsxNyt1YXpkNFRqWkRWU21nWGlRSkJPWlRPWlptLzlIRzVl?=
 =?utf-8?B?aVNscGt3NWpvUmQrWGtadWJxQWhYdVd3bnpCU2JGYkM1THJFVExPd3pMYlhv?=
 =?utf-8?B?ZkdrZHduVTF3WERrUjdRUFNNSkpaVU9yc2diK2tjWTZVMTNPcldTalNJWFdi?=
 =?utf-8?B?RGswK1VXSVFXc2hOMGFqa295MGZCTjNha1VtbEJxNW5oVERKbHArWDlSOUpV?=
 =?utf-8?B?Qk05QkpNK0wvMHA1WXRUTUVlYjBReDZNUFNZUHI0OXFjQmpmSnRlSGN3elhT?=
 =?utf-8?B?aXA3NGkzNExyd2QwcERWOHZiRCtwbkZyaEk4OHp6N3ZRTEFWT0dTVVEvZXhs?=
 =?utf-8?B?Y3pIZTdkZnBUOWc5bkhqNXZBSXZBQktsaHQzcyt0MFhTYU9sRGI1YWFFWVB1?=
 =?utf-8?B?ZFVwd2JTWU8wWGx5d3BGSTBTV2lsQzRHcFhuRFl0MlZkNXlhckExcDd6ZExQ?=
 =?utf-8?B?cGlYamRiYXM1KzZSQ2tobXVORE1oOThMTUNKeUt1R2dNdnRITGJ0THYwOGI3?=
 =?utf-8?B?VStsMVdmL3lDRVZGNUNPcTdNenZwZ0JyRTV5VkNHQ1RDUUhMaDlkbUhjTVI3?=
 =?utf-8?B?Z1d4d09WbGFNcjZmMkVUNGNZUWFIcWxFRVNydHZmZlgrZ1NwVmdqREEyN1Nx?=
 =?utf-8?B?YjhUa3cyWm5mUVhTb0JvaEFhanJ4bTB0bFNQaEw1UCs3V1h1dTZaRjQrVHcw?=
 =?utf-8?B?YmlGeVNyOGdNYzZTMmg3dktZRElOT1BuZTZNUzJtaGU2MExHcWtmcFpYaWN1?=
 =?utf-8?Q?D8C6BlWRMXfsDUy/hJjTUcJZT?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3363d888-cebe-4d2d-ac60-08dbf68004b8
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 17:23:10.0588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuIW2RVTv21R6oOCSKmjCVrqxpvoVaQdUPmKM3+gpZghvjq4XyZvQGbTUSnySiZWZUB+73NAWQfWuSSWJIcjdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB2121
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28042.001
X-TMASE-Result: 10--25.198100-4.000000
X-TMASE-MatchedRID: 9d2LtCNB3NL5ETspAEX/ngw4DIWv1jSVbU+XbFYs1xIug34e93J3tnkS
        2NLbu9vrULbG0rixd+E36a72PkONVNLnVLHHb0BJCWdkPey/ud0mYiLmWG1HXbQNCmAbUSvDZXX
        36/BmC080NJHPQN9UArP4c0qfJoGz7d+xf/FbvJfPEeDcxvUDjBdg35AjTNkx5aLISmJsQyVoAM
        7p/7Q4FgngCytgDOwu3wndydrxpzGBhoOMWK4RiyVDHvrOXL2je7c6tEkXezt4MCaOUDLFfUjE5
        FbJIU5rM/JSAap9TdfZ3LjxMJJFV4rPk06BAVBX11qnBW8yYK9izPYC140hyBNYAPMgIJLFYnC7
        ZbHmwKhhoj1DnvABVppsX71XTVcqni8H5yYlKS9B8QeybLLpAnADCJNicMiEQmKE8OTMVIjDmdn
        LZf43Hu6BDVJFY6GhqjNFYgU2//vQKj5kaEbfmcVNAYApHGPk2j7jyCKpnCcSCDdzAMeX/Wp2VX
        UuZsR8A/lH/MvdoiYmkrgX3CciJpBlLa6MK1y4
X-TMASE-XGENCLOUD: f7729641-1367-4071-a5b0-841cd88d8349-0-0-200-0
X-TM-Deliver-Signature: 515AE1AA957D086FE9F6D2EC2F937B0D
X-TM-Addin-Auth: 8D9F/B+St5jXmQUxWpVJlCYzMw7jn3/wpkdo2ShA1w7uO1Ib+Lem1YItyBT
        B0MhZSCQDCLyhTmbmXEz8+hiokkhUMlaxlF987t+q5iqjQ1p02hSTIKx/wkNmZO2w4lHciDtbW5
        kGjRJenBdCa6xSL3ZoynqfJf3Q4N3rCIyHLRhD8CD//xNPWRoBV57IbxlkQp2ycAKEsulFujRqn
        bEpox2yv+BS3Q8a/bPv2L58i1tjS6QQ1ZBnYTAghr6ghHIn+nCZ/SYLS8ziUPrcAbkP3i+ddeyJ
        QDKyIQjtoElAJAs=.3OUKeFwKTcpJapU9O4Q2NJ7ZB++eWl02FAE5U/ECH7OGhWnH5bimikHVFY
        1LYCX+Mqk7NoHPw0QEJiK3NbkJkca/dfqU9/TfdhhDLwFHmUNzymN3PA5+tRmQfw13XuSo9a9jK
        wGp+VefQNODH5pXrH5WGHptV14WIgjb4ky7LEvT+t/5CWrBGDAwHgOXGLnqnmXwXS8ceYPiwjiE
        eivzaz3NNhaUDzJprVvH32FAc9CejqVp8GXxz8Cmgzp4fQItDVG9Ss9KWBkacLHtIkchjlQtfxt
        QiprrihY+0Fw3Qc8ay4HG0KdUFxpGkuBcGcCvsX7bf72eLVc5N8rArExrlw==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1701883391;
        bh=hSdNxp4lSJ6+QKXhyHS2u9CczwmApyKAiidnKo5xYXk=; l=3661;
        h=Date:To:From;
        b=XB8YJv2ebS7LpgY1QzMi14bVfxD2lYV6PO5Mg+xQOSjzWRhdO0XDyrZxqP0pt4Ov0
         qsCZnsmo2rsOQ0hRK0YvNkev5y9gRIXzF1ob3Tlh5Q22j9TFsjXNcepGxOOyCHpTgY
         NFUR+cG5s6ZXKoFWgm3FgFHSjnxRgHCP4jM03heQr6ms7AuuWCkaNV4RTGl0U/crYw
         rnprsz++mb0uxXROYyR2uPHPfGTlw/rVscyQxOuB96VizozucUXsIazyXm1p1ZnAu7
         MhpetrGNVCVDYkKOVeP2XhcPfLM+/rl+0qCE7b2O2HpZJcLtSWTKGqUjRKMLEQ0g+F
         jVrcef6X/NPlA==
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.11.23 14:48, Mark Brown wrote:
> On Fri, Oct 27, 2023 at 06:10:16PM +0200, Harald Mommer wrote:
>
>> +config SPI_VIRTIO
>> +	tristate "Virtio SPI SPI Controller"
>> +	depends on VIRTIO
>> +	help
>> +	  This enables the Virtio SPI driver.
>> +
>> +	  Virtio SPI is an SPI driver for virtual machines using Virtio.
>> +
>> +	  If your Linux is a virtual machine using Virtio, say Y here.
>> +
> This advice is going to be inappropriate for the majortiy of guests.
Reminder for me: Need still to address this, but this is not code I'm 
currently working on, so comes later.
>> +	// clang-format off
>> +	struct spi_transfer_head transfer_head	____cacheline_aligned;
>> +	const uint8_t *tx_buf			____cacheline_aligned;
>> +	uint8_t *rx_buf				____cacheline_aligned;
>> +	struct spi_transfer_result result	____cacheline_aligned;
>> +	// clang-format on
> Remove this clang-format stuff.
Not needed any more, will be removed. Maybe I should remove this 
____cacheline_aligned. It's only there because I looked too deeply into 
struct virtio_i2c_req, not because I think this ____cacheline_aligned is 
decisive here.
>> +static struct spi_board_info board_info = {
>> +	.modalias = "spi-virtio",
>> +	.max_speed_hz = 125000000, /* Arbitrary very high limit */
>> +	.bus_num = 0, /* Patched later during initialization */
>> +	.chip_select = 0, /* Patched later during initialization */
>> +	.mode = SPI_MODE_0,
>> +};
>> +/* Compare with file i2c_virtio.c structure virtio_i2c_msg_done */
> In what way is one supposed to compare with the i2c driver?  What
> happens if the I2C driver changes?  It would be better to ensure that
> the code can be read and understood as a standalone thing.
It was a reminder for me from where I got some inspiration and to reveal 
that not everything was invented by me. Served it's purpose, all such 
comment references to foreign code is being removed.
>> +	/* Fill struct spi_transfer_head */
>> +	th->slave_id = spi->chip_select;
> If the spec just copied the Linux terminology it'd have few issues :(
Spec changed this in the meantime so I can do also.
>> +	th->bits_per_word = spi->bits_per_word;
>> +	th->cs_change = xfer->cs_change;
> The virtio spec for cs_change is *not* what the Linux cs_change field
> does, this will not do the right thing.

This is a hard one. Linux says (spi.h):

"@cs_change: affects chipselect after this transfer completes

...

All SPI transfers start with the relevant chipselect active. Normally
it stays selected until after the last transfer in a message. Drivers
can affect the chipselect signal using cs_change."

V8 of the draft spec says:

"cs_change indicates whether to deselect device before starting the next 
SPI transfer, 0 means chipselect
keep asserted and 1 means chipselect deasserted then asserted again."

What I understand here (unfortunately in both texts) is

- at the start of a transfer CS is made active

- it is kept active during the transfer

- when cs_change is 0 after the transfer CS is kept active (not changed)

- when cs_change is 1 after the transfer CS is de-asserted

So if cs_change is 0 keep CS asserted after transfer, otherwise 
de-assert after transfer.

I fear there is some subtle thing I haven't gotten yet but I don't 
understand / see it.What is it?

>> +	th->tx_nbits = xfer->tx_nbits;
>> +	th->rx_nbits = xfer->rx_nbits;
>> +	th->reserved[0] = 0;
>> +	th->reserved[1] = 0;
>> +	th->reserved[2] = 0;
>> +
>> +#if (VIRTIO_SPI_CPHA != SPI_CPHA)
>> +#error VIRTIO_SPI_CPHA != SPI_CPHA
>> +#endif
> BUILD_BUG_ON()

Thanks for this one, didn't know yet.

