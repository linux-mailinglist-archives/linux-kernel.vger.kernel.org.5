Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2D17B0C66
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 21:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjI0TJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 15:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0TJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 15:09:12 -0400
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0558F;
        Wed, 27 Sep 2023 12:09:09 -0700 (PDT)
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R6577e014490;
        Wed, 27 Sep 2023 19:08:37 GMT
Received: from deu01-be0-obe.outbound.protection.outlook.com (mail-be0deu01lp2171.outbound.protection.outlook.com [104.47.7.171])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3t9pcw3cqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 19:08:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PucleqzD3oed/C67wvDFmsE+D4rXqvlBK5v88tnsaSPW5C3sz30Fwt0DmG5Og2YxbY/leD92KJFIpfGdPfk7HKKJDdKdqKsnA4BXIyEXqFg1GSHZ4kYtJvLr8HhSuVeNmBx799rE2qJDbVpF4yHpLzwqQb9u1fwebMsIgIPlJJpan0HjNitX9GcXsNDdpXbAUOlkxBgTm/KfiYU+0/ls1QPrc4yRp5p+Znh/KSc7UuYnnJiHkE/+pZw3BmhFVJbqPkeWgzoBCrO+SbIz71N+j8Nqwp5kXUVGPy2w4PZ7gVRw9gbGHlU428AEdtX+AUtjm5jLC4jfcVy3IoIVd+uNgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrSpq5rutEOoUmD1jWOdPcZ4YMbipW3ZxINR3uYRk1E=;
 b=FewF3ao8JZ2ciKYs/7AKSMGA2onB3VPcI8/QUE6OiZmzWwA76+dZJ72Ey72mhQuuI0QbxYmOS7eAQbtYxwN67bfdKM5/SIoRFdOKQoW4hBQD7SlZdX/WXmdS7jWu4rQXLdfn702rj1ypAImrjGtaUinVRBgHkJylVkz4wBVg4l9R1dNaPFN9RV+uDmX8DQ69UI05NywHiUAPRGJth7ugJG7h9sIQZTKRD+X36kQkw8040crOIRLnO9DVbQ+WVMensWxCJp2JDi5idOk7zLT/qeNC52UvYf0IQ01FSW5BSvh5ZQDAxkVVumxPE8C7EB7QMBwK/9V3IDVvRo1XkOpYkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrSpq5rutEOoUmD1jWOdPcZ4YMbipW3ZxINR3uYRk1E=;
 b=E5arJPtxk99ZCjU3xwNMkuZjtv+8wCaqgzugS/jWIJSRxvlGMCpysLwgrAAj4OfiR8175F2lwtf+jhTkNYYIBv5RhtXoTgkU1wCtBUJpOfTLQAJfzo9cgjpBFuqQ6xfatg5gB7z1f57xcxAdzOYlL58XgcOuqrMIffOtVS2KCH8AiJXO/bpvi5cn6k+/bm+uhALQsQEv+ANwNF9J3DMNCIWTumHmcyY70G5c4N6Mxy8g7pXpaie0FGxXK3zjJzabYjNXs7AbV9FnBf6Q/k0aJCAOdxC84ZXf8+7swZN3ZeJUUWbpysGxae5YwZ+TQKWcxj6rp6V1NC2JzpH7vinWWg==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FRYP281MB3036.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:71::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 19:08:31 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae2b:f2de:3e65:280f]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae2b:f2de:3e65:280f%3]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 19:08:31 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Andreas Kemnade <andreas@kemnade.info>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "bcousson@baylibre.com" <bcousson@baylibre.com>,
        "tony@atomide.com" <tony@atomide.com>,
        "chenhuiz@axis.com" <chenhuiz@axis.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] iio: imu: mpu6050: add level shifter flag
Thread-Topic: [PATCH v3 2/3] iio: imu: mpu6050: add level shifter flag
Thread-Index: AQHZ8WizO21Uoo0ulUW09QEYGPCjlLAvCMGo
Date:   Wed, 27 Sep 2023 19:08:31 +0000
Message-ID: <FR3P281MB1757489A956DC26596AA90B6CEC2A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20230927173245.2151083-1-andreas@kemnade.info>
 <20230927173245.2151083-3-andreas@kemnade.info>
In-Reply-To: <20230927173245.2151083-3-andreas@kemnade.info>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FRYP281MB3036:EE_
x-ms-office365-filtering-correlation-id: 6de06dc6-2c3a-498e-bdec-08dbbf8d23ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ezxP+5u6G+IUyat0ZVM9gV/6Lnx5j58zhf31VjNaTwjh8c23r34JWayxYiFqECBtYKdD7h7vCE2bd36YNQ9y0R0n7miyM0sufYVLjE1MNBvtjIODvvYXx4RReFaVmPuE0mbhhn9VZAuFkbXS1mj4GGtYHKuYJnkJ3w05nmzrLb+sEsvcSt7EKzcfHJYIlQJuDoVIPuyawaNVHY0Of2WyQ/NkmU/7Ph7M3Uha8wqcUqiN4Le0TBU8UsjGKNoUGvAud3u0ycrIIrdauW/5AL57Dh2uKnkM5PSxYos7P8bPUzEmV9IhfSpwbgU7d6mohmnNE2mtJwYwTQdUONnJ2SwzUtuMB53MKRSRvkPJcMMFIioHOhKgsb0qIRdGpeZoFA0vepAuDzrhZRY/GLgw3BgaQXKeixuD9qRR2Xau8yC6CtHSH+Y0lUAMcF94L6d4u5c4J7Y4YMvP4ByI07vPdJx6LJt/GJHXlxdRJfSu26sKCGvd797bQmKLZajCtf1RIy4BwVaUtuoCjStjI1sjFbrZth4pZuTeXXPPciZJ8tjAcbTefZKMq2oTkhq3mIKqYCPcjF/byd6Y/fIzXiNp/6OFqPxy2TTOcz4fj5SM0/uwBq25GXlAkethfrkYokcGvWBZHnk2mwCJC3IODn/XJeLpLoFQUMsfRcHZZKgcioDPaBmH9QUlqyzXoSRcVC8l0A2p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39850400004)(366004)(396003)(230922051799003)(1800799009)(186009)(451199024)(83380400001)(38100700002)(33656002)(86362001)(55016003)(122000001)(64756008)(38070700005)(316002)(41300700001)(52536014)(66946007)(76116006)(110136005)(8936002)(8676002)(7416002)(921005)(2906002)(5660300002)(9686003)(66446008)(91956017)(66556008)(53546011)(478600001)(7696005)(66476007)(6506007)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?am1wZWIxQllMQytwR3BBeFcrbXFQaDF5WmJCa1N2cW1uL0RxbTBybUR2MUZm?=
 =?utf-8?B?dDdsTjdzelFPYnNIN210TXIzL3pHZW9sMHFJVUdyOE9zTmZVS3JwUFdxNngr?=
 =?utf-8?B?S2MveUJxemVwRjU5U2JZdklDdEpmU1B2aTVEd2ZYRGZyS3JSWTYvQkNJQWpp?=
 =?utf-8?B?bStKcG9JWUZLODZpUGtzQTVBdUhMY1JYMldnblAxb3YvTUs4ZDhDTEh4b1l4?=
 =?utf-8?B?akw2ZzdMMzVnWVoxZEJaRGR0SDNaZks3MmdwamRsQVNqYXdxUEZ3dFlDN2N6?=
 =?utf-8?B?NEZMVGdjMWcxc2pteFFFVnQybHlPdWRNWHFRVkVhWU9JM3lHbUVIYmkrVWlJ?=
 =?utf-8?B?VG1HZWg1ZGhabDZETlVZbERqNG9SMjJON3N2bll5RkVKb1hIVFpOYnE4Z3Jx?=
 =?utf-8?B?TEFRcERrS2tnazRVS3l3THJPVEM5VGJBYTNBRWtSb3RDL2ZpckJCYm8zaEVN?=
 =?utf-8?B?WGNlSlB2UUtGQWlyek5zTmdKV0FNM1IzcGhscXFrQk53a1hsdlZYNXRzTzM0?=
 =?utf-8?B?ODJIWm9hcnhmT3ZIWTV2Sm1Pa2lXMmFOM0g4clF0Ymg4dGkvb1RIeDYycTg5?=
 =?utf-8?B?NDlsU1IxZ0dWYXI1bkdrQjVMYXBLS0RZQWZpNEVDYnRxdFpYTXVxZE83dzlG?=
 =?utf-8?B?SlYrZU9rZUd0YnlLclRBZitWRUIrZEwreENXYjhqWEFGS1dONytSQWNQVFNs?=
 =?utf-8?B?a2J5empTclU5ZUFPMnZmdHJzdkNKcXRnNHRVa0xKVGtDWkV5TGZ0VldWWlNM?=
 =?utf-8?B?aWdyR2U4VVRuVUJJNWhuY05pV1ZJbXd3QUk0S2pQNG5YdDQyTTVSRjJzYjFi?=
 =?utf-8?B?d0xzM1d5WkgvUU5aN0JMenY5M3dnRTJXQ0ZGOENuSkdRR3MvZ3RQWTEyVnBy?=
 =?utf-8?B?M3FUNzNtQXRhQ2FoVFEwTkFVY3BGbTFRbU0rR2MvWVVNeDlnaTRyODN2OVBQ?=
 =?utf-8?B?ZzRMbTFCR3B4OVQ5T3pFb0ROT3BaM0U5TldIbUZ1VW82dXYvcjFCQkYzR3BI?=
 =?utf-8?B?Z2pPNU00Y2VwYy80Nmc2S3R5OFVvVWxuWEMya3VRNkM5ZXA3UVN1VW50eitB?=
 =?utf-8?B?Z283aHNjdXBlYy9sMHIrTWdPOStTL1d1dElPUmpoNEZYQjJrMGFKc1pFNW4r?=
 =?utf-8?B?bFNXNHMveUgrYlpCYzh3S0xIbmFiaTF3Vm9KZnVEOHl2eG1QZGJHR0NuWllE?=
 =?utf-8?B?Zit4cTIzSVpINWlXUFZXdW14dlNrM2JqNW9uVUh4L3Z2Snpka3lRNFBqZkVw?=
 =?utf-8?B?blFPdmdqSi9jWEtaVDlhQVRkVndmS0JTVkpsSWcySDRJd2xWdXQxTkprZTg2?=
 =?utf-8?B?SmQ3Z2lnV2NYUm9oRVJ5RGlZcCtTL1RQeXpwU2c0TmRZaTlDd01CbnQrUHpk?=
 =?utf-8?B?cHRRVXJ6UUpIZGRvMXRDL2d6alRRYUQ0OS9kQVl3YXJPd1R1dEFXQW5XdVVz?=
 =?utf-8?B?eG8wbUs1VWRvU3lPOW9RS2V0VHppVXBsWFFrR2VHRk5vdGJyaG83SFVDMWNr?=
 =?utf-8?B?K0I0T2s5YkZ2MGl3NHJTUzhlL0l3bWNwQk5KRkNuRUpJT290cTgxY09wbkxF?=
 =?utf-8?B?cGtDS296cHFWa0N5blpSYjVZdWc0WkJuQ2lNeFd2dis1d2d1eVpLU1ZLTUkw?=
 =?utf-8?B?d1ZKcTc3T0dFZFhYZ0l4aFpraDVaRnNya1RHT1ZKbTBSd3docDBhdHNTUkRY?=
 =?utf-8?B?cTdXQ2t5UnRXODVpSzVFaUN3dDQ4ZlhkeURkaUlsVEJrQWdXSUhnQ1pnNHBB?=
 =?utf-8?B?Uk1yUlBUZUZSdHdOTXZTZy90OGJBZktWU2JCVlJCZEpHZXJSVGpCTzdpQVNZ?=
 =?utf-8?B?ZEc5OUZyL3RXdjZvR3p3TDhQbEsybzJXN05kcGxWeEYvVGVIZTNFRi8yeDNE?=
 =?utf-8?B?WlI2dCtMUzRvUjJFR2loTStES1Iwd0dqQlBUNU5rc3l2ZW9zZi9UQWNmQWhI?=
 =?utf-8?B?ZVVwZmd5RHNUNVYraXdHYyt1Z2RRS2lJZHhlakw4TGZJcFZRZTVnbEt5V0JC?=
 =?utf-8?B?eHdnQjV1Zk5yOFZmLzZGUTlFUHJUT1NuS3lQUCtsK0c3L25QZm5sUHd5SHlP?=
 =?utf-8?B?bllES2R1bEVObEZqVzlxMlZqeDFDZjBwVUtDdXRUZ2dsTWx6NU1abStreHkr?=
 =?utf-8?B?ejAvR2thbTZzNG81cGFkK2I2c0Z4L05wOUIwYVdmQ2tVb0FZQVg3QVU4TWF3?=
 =?utf-8?B?TkFjTDN1SHVFNElnTTRMdFN3UDlLWUM2NmVybVFBbEw0eWlLclFxMkF4cHlX?=
 =?utf-8?B?OWJ1cmFpOWd2eUFPcytLN2E1UnhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de06dc6-2c3a-498e-bdec-08dbbf8d23ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 19:08:31.7028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IxHk5Vn/NmhXrZ8ynXDnkEujlDsLoT4S78avY0Eg7imU0+bGQIjuHXBVysaBZn8xbKZ8jS8JQh3i88+kOK6QZYkhKojeZCqLbXfEmi9j/RE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB3036
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_12,2023-09-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sCgpsb29rcyBnb29kIGZvciBtZS4KCkFja2VkLWJ5OiBKZWFuLUJhcHRpc3RlIE1hbmV5
cm9sIDxqZWFuLWJhcHRpc3RlLm1hbmV5cm9sQHRkay5jb20+CgpUaGFua3MsCkpCCgoKRnJvbTog
QW5kcmVhcyBLZW1uYWRlIDxhbmRyZWFzQGtlbW5hZGUuaW5mbz4KU2VudDogV2VkbmVzZGF5LCBT
ZXB0ZW1iZXIgMjcsIDIwMjMgMTk6MzIKVG86IGppYzIzQGtlcm5lbC5vcmcgPGppYzIzQGtlcm5l
bC5vcmc+OyBsYXJzQG1ldGFmb28uZGUgPGxhcnNAbWV0YWZvby5kZT47IHJvYmgrZHRAa2VybmVs
Lm9yZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8u
b3JnIDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+OyBjb25vcitkdEBrZXJuZWwu
b3JnIDxjb25vcitkdEBrZXJuZWwub3JnPjsgYmNvdXNzb25AYmF5bGlicmUuY29tIDxiY291c3Nv
bkBiYXlsaWJyZS5jb20+OyB0b255QGF0b21pZGUuY29tIDx0b255QGF0b21pZGUuY29tPjsgYW5k
cmVhc0BrZW1uYWRlLmluZm8gPGFuZHJlYXNAa2VtbmFkZS5pbmZvPjsgY2hlbmh1aXpAYXhpcy5j
b20gPGNoZW5odWl6QGF4aXMuY29tPjsgSmVhbi1CYXB0aXN0ZSBNYW5leXJvbCA8SmVhbi1CYXB0
aXN0ZS5NYW5leXJvbEB0ZGsuY29tPjsgYW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbSA8YW5keS5z
aGV2Y2hlbmtvQGdtYWlsLmNvbT47IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWlp
b0B2Z2VyLmtlcm5lbC5vcmc+OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZyA8ZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIDxsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgbGludXgtb21hcEB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4
LW9tYXBAdmdlci5rZXJuZWwub3JnPgpTdWJqZWN0OiBbUEFUQ0ggdjMgMi8zXSBpaW86IGltdTog
bXB1NjA1MDogYWRkIGxldmVsIHNoaWZ0ZXIgZmxhZyAKwqAKU29tZSBib2FyZHMgZmFpbCBpbiBt
YWduZXRvbWV0ZXIgcHJvYmUgaWYgbGV2ZWwgc2hpZnRlciBmbGFnIGlzIG5vdCBzZXQsIGRlZmlu
aXRpb24gd2FzIGZvdW5kIGluIHRoZSB2ZW5kb3IgTGludXgga2VybmVsIHYzLuKAijAuIFNpZ25l
ZC1vZmYtYnk6IEFuZHJlYXMgS2VtbmFkZSA8YW5kcmVhc0DigIprZW1uYWRlLuKAimluZm8+IFJl
dmlld2VkLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHku4oCKc2hldmNoZW5rb0DigIpnbWFpbC7i
gIpjb20+IApaalFjbVFSWUZwZnB0QmFubmVyU3RhcnQKVGhpcyBNZXNzYWdlIElzIEZyb20gYW4g
RXh0ZXJuYWwgU2VuZGVyIApUaGlzIG1lc3NhZ2UgY2FtZSBmcm9tIG91dHNpZGUgeW91ciBvcmdh
bml6YXRpb24uIArCoApaalFjbVFSWUZwZnB0QmFubmVyRW5kClNvbWUgYm9hcmRzIGZhaWwgaW4g
bWFnbmV0b21ldGVyIHByb2JlIGlmIGxldmVsIHNoaWZ0ZXIgZmxhZyBpcyBub3Qgc2V0LApkZWZp
bml0aW9uIHdhcyBmb3VuZCBpbiB0aGUgdmVuZG9yIExpbnV4IGtlcm5lbCB2My4wLgoKU2lnbmVk
LW9mZi1ieTogQW5kcmVhcyBLZW1uYWRlIDxhbmRyZWFzQGtlbW5hZGUuaW5mbz4KUmV2aWV3ZWQt
Ynk6IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4KLS0tCiBkcml2
ZXJzL2lpby9pbXUvaW52X21wdTYwNTAvaW52X21wdV9hdXguYyAgfCAxMyArKysrKysrKysrKysr
CiBkcml2ZXJzL2lpby9pbXUvaW52X21wdTYwNTAvaW52X21wdV9jb3JlLmMgfCAgMyArKysKIGRy
aXZlcnMvaWlvL2ltdS9pbnZfbXB1NjA1MC9pbnZfbXB1X2lpby5oICB8ICAxICsKIDMgZmlsZXMg
Y2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2ltdS9p
bnZfbXB1NjA1MC9pbnZfbXB1X2F1eC5jIGIvZHJpdmVycy9paW8vaW11L2ludl9tcHU2MDUwL2lu
dl9tcHVfYXV4LmMKaW5kZXggNzMyN2U1NzIzZjk2MS4uOGE3ZjI5MTE5MDVhZiAxMDA2NDQKLS0t
IGEvZHJpdmVycy9paW8vaW11L2ludl9tcHU2MDUwL2ludl9tcHVfYXV4LmMKKysrIGIvZHJpdmVy
cy9paW8vaW11L2ludl9tcHU2MDUwL2ludl9tcHVfYXV4LmMKQEAgLTcxLDYgKzcxLDE5IEBAIGlu
dCBpbnZfbXB1X2F1eF9pbml0KGNvbnN0IHN0cnVjdCBpbnZfbXB1NjA1MF9zdGF0ZSAqc3QpCiAJ
dW5zaWduZWQgaW50IHZhbDsKIAlpbnQgcmV0OwogCisJLyoKKwkgKiBDb2RlIGJhc2VkIG9uIHRo
ZSB2ZW5kb3IgTGludXgga2VybmVsIHYzLjAsCisJICogdGhlIGV4YWN0IG1lYW5pbmcgaXMgdW5r
bm93bi4KKwkgKi8KKwlpZiAoc3QtPmNoaXBfdHlwZSA9PSBJTlZfTVBVOTE1MCkgeworCQl1bnNp
Z25lZCBpbnQgbWFzayA9IEJJVCg3KTsKKworCQl2YWwgPSBzdC0+bGV2ZWxfc2hpZnRlciA/IG1h
c2sgOiAwOworCQlyZXQgPSByZWdtYXBfdXBkYXRlX2JpdHMoc3QtPm1hcCwgMHgxLCBtYXNrLCB2
YWwpOworCQlpZiAocmV0KQorCQkJcmV0dXJuIHJldDsKKwl9CisKIAkvKiBjb25maWd1cmUgaTJj
IG1hc3RlciAqLwogCXZhbCA9IElOVl9NUFU2MDUwX0JJVFNfSTJDX01TVF9DTEtfNDAwS0haIHwK
IAkJCUlOVl9NUFU2MDUwX0JJVF9XQUlUX0ZPUl9FUzsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlv
L2ltdS9pbnZfbXB1NjA1MC9pbnZfbXB1X2NvcmUuYyBiL2RyaXZlcnMvaWlvL2ltdS9pbnZfbXB1
NjA1MC9pbnZfbXB1X2NvcmUuYwppbmRleCAyOWY5MDZjODg0YmQ4Li4zZmJlZWYxYTcwMTg2IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2lpby9pbXUvaW52X21wdTYwNTAvaW52X21wdV9jb3JlLmMKKysr
IGIvZHJpdmVycy9paW8vaW11L2ludl9tcHU2MDUwL2ludl9tcHVfY29yZS5jCkBAIC0xNyw2ICsx
Nyw3IEBACiAjaW5jbHVkZSA8bGludXgvcmVndWxhdG9yL2NvbnN1bWVyLmg+CiAjaW5jbHVkZSA8
bGludXgvcG0uaD4KICNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+CisjaW5jbHVkZSA8bGlu
dXgvcHJvcGVydHkuaD4KIAogI2luY2x1ZGUgPGxpbnV4L2lpby9jb21tb24vaW52X3NlbnNvcnNf
dGltZXN0YW1wLmg+CiAjaW5jbHVkZSA8bGludXgvaWlvL2lpby5oPgpAQCAtMTQ5NSw2ICsxNDk2
LDggQEAgaW50IGludl9tcHVfY29yZV9wcm9iZShzdHJ1Y3QgcmVnbWFwICpyZWdtYXAsIGludCBp
cnEsIGNvbnN0IGNoYXIgKm5hbWUsCiAJc3QtPmlycSA9IGlycTsKIAlzdC0+bWFwID0gcmVnbWFw
OwogCisJc3QtPmxldmVsX3NoaWZ0ZXIgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKGRldiwK
KwkJCQkJCSAgICAgICJpbnZlbnNlbnNlLGxldmVsLXNoaWZ0ZXIiKTsKIAlwZGF0YSA9IGRldl9n
ZXRfcGxhdGRhdGEoZGV2KTsKIAlpZiAoIXBkYXRhKSB7CiAJCXJlc3VsdCA9IGlpb19yZWFkX21v
dW50X21hdHJpeChkZXYsICZzdC0+b3JpZW50YXRpb24pOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
aW8vaW11L2ludl9tcHU2MDUwL2ludl9tcHVfaWlvLmggYi9kcml2ZXJzL2lpby9pbXUvaW52X21w
dTYwNTAvaW52X21wdV9paW8uaAppbmRleCBlZDVhOTZlNzhkZjA1Li43ZWJhMTQzOWM4MDkzIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2lpby9pbXUvaW52X21wdTYwNTAvaW52X21wdV9paW8uaAorKysg
Yi9kcml2ZXJzL2lpby9pbXUvaW52X21wdTYwNTAvaW52X21wdV9paW8uaApAQCAtMjAzLDYgKzIw
Myw3IEBAIHN0cnVjdCBpbnZfbXB1NjA1MF9zdGF0ZSB7CiAJczMyIG1hZ25fcmF3X3RvX2dhdXNz
WzNdOwogCXN0cnVjdCBpaW9fbW91bnRfbWF0cml4IG1hZ25fb3JpZW50OwogCXVuc2lnbmVkIGlu
dCBzdXNwZW5kZWRfc2Vuc29yczsKKwlib29sIGxldmVsX3NoaWZ0ZXI7CiAJdTggKmRhdGE7CiB9
OwogCi0tIAoyLjM5LjIKCg==
