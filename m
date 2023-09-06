Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105DE793D64
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241061AbjIFNFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjIFNFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:05:47 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1786DCC7;
        Wed,  6 Sep 2023 06:05:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UT2yCEvZLOmZsc/w/yaQ+zxRwbthw9U/6bng0XjNVNSXRotsUovvTDCSCJtLgjNjEpXulKVmJV+URfj9Xb3KwAxOZpOUcxbgBASg4/WnYAgEkc3xSMHtCUvLwxuiBoPxrnSbLxdXOhXzupKvsEQTWO4duVtlj4rtBjPFuQyJ8FGQT2Xgc7sdko4FsHCVvJbqmQIUjfA42rgQU/KNPX2X2TBENIQSwTFqP1FIhi48cBB+ULJOxkzKnbVksmSoK75Dk25dWYS4FFytt/v3n7l8HU5PyHMI9vt+er9vYr3TJLzu6EIxVhAxlJyINUW4oKTcR16O0xJOg9Oxpfgmq0Z61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fx/Xpi9daE3ohL9QrV0fVxFYwc36T0qxuYwaRn/9Dh4=;
 b=byqiblV4t/UvyYF+Et/J3/bbVR4MONHgL2dektsca/e52l4eawa6P9RHMXHjj+o4ITAjW/aY5CZECF9rFsiwtdnW90X9PxgqkpXLu53qOv9lDL74da0+hepiDAjw2eFoO5e7xGoYKtND7Ye95oUEjEC65ew92aeJc9ghRdUDIMaZGYdykZk/ZnkWJtkjz2aNI4+k7G0QH3NyO+j2tTl7vQpsAVvvqpq9GIG52MzjNkjdekkrGup1uY2hHMEIZs8+8IaIlrha8dygCCy6kqF6TsbTl+hL1HDkCyo3Wnk/95bhpIP9y8tzLQrtv1/gyUDmLsHqHkTMlWb5eMAWJiKdyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fx/Xpi9daE3ohL9QrV0fVxFYwc36T0qxuYwaRn/9Dh4=;
 b=EUub35X4Yf5M9k6Ce95TwAwCA7G6aCmODWcsCo/0yPf6QNTjvVDN0iXb7qpwV9febud3WNYnQrJH0msl3eSUS698tPwKnlVnmATwlxlTQA9lTQOjZ5inRdosOxklLQCtWBaoy4MSBOb3zVo+DzV7KCOyLWeP1FGks9gUr5ijkwsaGeWLcT/PwH8EhTOrHHvI+5c6GP1+8ki98ytzuuTfERewHm/q53GrJ7CIdRbW8IH3kBQJNh5bBUhUpqdYNiqG2vM64IvMyMyaIq3SnPxpkqX9I/rjnjltffEIBRyw/twO0qbCYz4SGyTITpbXrp0vdLOZgEa51TtABGY4Pg7LyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM6PR04MB6311.eurprd04.prod.outlook.com (2603:10a6:20b:b7::20)
 by AM9PR04MB8779.eurprd04.prod.outlook.com (2603:10a6:20b:40a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 13:05:39 +0000
Received: from AM6PR04MB6311.eurprd04.prod.outlook.com
 ([fe80::e8bd:7711:50e:aaab]) by AM6PR04MB6311.eurprd04.prod.outlook.com
 ([fe80::e8bd:7711:50e:aaab%4]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 13:05:39 +0000
Message-ID: <4a372872-bc3d-8975-4d7b-6d8650836e3c@theobroma-systems.com>
Date:   Wed, 6 Sep 2023 15:05:37 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/2] arm64: dts: rockchip: use codec as clock master on
 px30-ringneck-haikou
To:     quentin.schulz@theobroma-systems.com,
        Jakob Unterwurzacher <jakobunt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Ermin Sunj <ermin.sunj@theobroma-systems.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230823131651.586934-1-jakob.unterwurzacher@theobroma-systems.com>
 <051ceb69-2f6b-4944-4fbe-0ced66f0b669@theobroma-systems.com>
From:   Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
In-Reply-To: <051ceb69-2f6b-4944-4fbe-0ced66f0b669@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0146.eurprd07.prod.outlook.com
 (2603:10a6:802:16::33) To AM6PR04MB6311.eurprd04.prod.outlook.com
 (2603:10a6:20b:b7::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6311:EE_|AM9PR04MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: c21b964f-2b51-4331-251a-08dbaed9f7e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njDstdfZInb5n7apX2WHPDef0sRHyg5LV35fP3ONqKYMXyrjdNDLNPK5YsUqWO2jmxuXan8p9YTqLjaP7ppyjLzU9UR/JsyaXYQv9VbN+b4m9+B1m+5OnIEFiEPs8ASWrLCcYxwreIa8N8EjGK+6PjwEt+Ey+kdiZ4Fi8ovMuwix8592oI7JbMOA6FH9Ikz06/z5OU/BVEv4wHvcnHAej1nm4ZMCCdB3UFaUk+hdqU7nFaGfygOnUNs5QkJwBxYF5/cjleAuuyD/xhAtX3Ql8lQPyYTTQbAp6wqOqPckEeDC2S9xqeOo/BcKaw18WvQx1ehQIeIy6hZSBqpkNq34vyIvvqTJouvuygWw3fdYNwM0O3DB18LHJfhQ1g1s/JjX76xgegmNZkJwT/K4YYuxRLuWc1zvBUGIU/8d0A65TRmjjceL/WMCNz8+DrX3JMQrv+deKuRY4N2S6y/7rhGucHZjzTjyMLpLdPD+2JUj8/vKt8jWmT5AuFkWDl8KsN+5beSMSUpk0ccXGpI0fN61q3AzJLT/5vfgC8SOP+Cos7MFeMKWywfFNTKaeWGRbxbP4ukS9BHEHJNaa0KqpipuZ7X8Z3q1kjGVcfq1WVg0XVnkh/ubYWRwFQon11wpn2pcfzPIaJ4OywprWBJiokQ2c/3y5FtjfjR5l6tjTUaRptU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6311.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39850400004)(396003)(451199024)(186009)(1800799009)(41300700001)(558084003)(44832011)(5660300002)(31696002)(86362001)(478600001)(2906002)(8936002)(8676002)(316002)(66556008)(110136005)(66476007)(66946007)(31686004)(26005)(53546011)(6486002)(6506007)(2616005)(38100700002)(921005)(6512007)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkEwRXpmRGhCRXFsQ0pSVjZWTm5FYzJZZ1l6bVowZnBmRFg5RWs3QWxpemxo?=
 =?utf-8?B?TDdZNmpHYWxQanE4aURselVXblNETlJjMmZJRWZvUTZTaGpzVmdSaEtodjJD?=
 =?utf-8?B?aUJoL2xOSUF0QzFpVWVjRVc3WXZXYTFGTkh0ZEVETnovY1MrclZOT0hCb1d6?=
 =?utf-8?B?RGhNZTNNZVFqVlBlV0xBa2hZZnVpandJOCt3cVpidXhKaWtzZXVXVW9idHBu?=
 =?utf-8?B?NTE0YVNqWnhNNUs2NlFsSnlETUxDeXZjUUdYcGtsZFcweUdiYTU2TjIycWEw?=
 =?utf-8?B?aXlVT09MLzlsZ1pNemRGSHNMYlVlbDdnRXdmMlpPNDBLTHZGWTdremo2RmFq?=
 =?utf-8?B?dW5LSVlTNEFBY1VxSEhZUGRNb0xmQ0cxRTY1dkhpVFllT0llbG9TeDRMajFw?=
 =?utf-8?B?NG56VWdMNklJTGg2VWRLdDd1R05qYytseDYzeWV1NzBNazBGb09FZFFwcS8y?=
 =?utf-8?B?bTVrM2hwUnBIMGI1RjNvdkprSTlpc2RoUWpvaGJHMU5kZlNyazByNlM1N2E0?=
 =?utf-8?B?UjQ0bWNHMEpjc3JjMWZETlNydk9Ia3p4RUJOUnVhK0tQeU03bEFjS2x2Uldx?=
 =?utf-8?B?ZHBPYXZOdmVvREx4UlFrVURmbG54VEE5WTE4N0w4aXM0blMzRnVaZHE2Q3o5?=
 =?utf-8?B?TlA2NHBXa3ZNcHNHYzM4T2hXMkx0a1YwLzZSbjNDK0FadXpVWHpPTnRwOXdH?=
 =?utf-8?B?eHFxK29oVUt0S1VSN1BuS3JTaDl3bWRnenpBYmtTNE5aWWRuLzdBSUVFdjFt?=
 =?utf-8?B?dmZHaTl5aElZUWkzRHhuNExjaURrREJjaWZ2K3BOQjA5VXMrQkN6NDZlWTkr?=
 =?utf-8?B?NGVrdllrbzZ2clIrcUsyR05YOVBhVlRvSlp5TGloSjd0RGg4MXBhR1VTTTRI?=
 =?utf-8?B?bkpRak85c2lsZEVocVFSb0JzZlgwV1BhTTdyLzUvTXBadkZQd25aVGJTb3FG?=
 =?utf-8?B?a2M4NUpuVW9NcW9TajZqT2hGcUUvMXBMK2hEWFRKeHNQTUNyTUdtQ1JGYi9q?=
 =?utf-8?B?a3pUbUFLZE01aHc4WVBUWjVXWm1ZemsraWZQRCtCSEJWS09ubldMZTNpOHZI?=
 =?utf-8?B?a2dNRjR3WUpXQ0RjaFp2OS95c0VXVkdNcHVybTRhSGVxSHorUFkxQ1IreEVB?=
 =?utf-8?B?bVA2Qkdwek53aXpKSlhJd0pUWUJVVHVYek4xMTVEUG1kYWZqbndMMThqUG9u?=
 =?utf-8?B?SVVQZTgwWGROZFNYb2F0LzJIMmFkTU40QkNOOWs0T1NUT0ZaUGFjV1h2UXFI?=
 =?utf-8?B?cXRlUURlNk5YTWFxbC9JeHJiN0YxY0tJTFU4SEpVNmRtY3FsS1BxeEh0NjVK?=
 =?utf-8?B?Q0w5aEpzbzk1bVg1RkFHczJPcmVHNEVoVDU0UnJwaG43TVk3MkMzdkZCZlNh?=
 =?utf-8?B?Q0RxQTU5RXA3Y1NOTU5Tc0ZqMEY1MnY4YU1xQWsxQlVsUDZLWVRNMEZNbGJN?=
 =?utf-8?B?Ui9zVWVaUmFGRWIybHIvUjY4eTN2K1A2MnNUYXpmd0dOU1FvNWNBM1pDNTk5?=
 =?utf-8?B?RTZ6U09OOE81c1J2N0Y3WHNjVTU5MnJJaFlDaENRS2xVMHk4bExpU1ROS0Ft?=
 =?utf-8?B?aXJSaEdHVjcyWTZRV2VTNVp4ZDViMUYzc2VoUTU1VUFscFh3eVJsOFhINEtB?=
 =?utf-8?B?UFRFdTVwNG1haWpOcEtKa3NOdmx6R21hUjY0K3k3M1hYNmNSeG1Sc0NoSGtH?=
 =?utf-8?B?UFAyRFZ4blExOEV0MFFMb2ZQTWw2eW90Y2FPa081OHVHQ1k4R3hQeGUvc29s?=
 =?utf-8?B?T1JzZ0drZW40MXg5Z1RaVUVOSHNoV3pmRjUzQVk1dFNPczZxb2FWKzhUZDZ0?=
 =?utf-8?B?SlFjNm5rU0FvdVRpaHl0bXppZmhZaGtFZU9QSG1ZSlhtWkltd0tKVWdpcGVM?=
 =?utf-8?B?cms4UEd0Q29xZDNmSjZPYkUyaS9OQUhlb1FMSi9PTGFDMUY5dUhnakd6Ky9L?=
 =?utf-8?B?dWNWaGUrUTArZFRlNGxUNnFDY1A1cjRlSEwxRTE3TXdzd0lFdmNmUzJNNGM1?=
 =?utf-8?B?amhONkREaGFGVmxvYnFOQWUrTExoMVNHTEIxYlZLa09xbytuT053ekJKcnFm?=
 =?utf-8?B?U2o3cnFDd2Vyd2N4Y2ptQnVPWEtEQkQ2TFhUR0w3dUdKa1o5YXVVdndWMnhp?=
 =?utf-8?B?d1pPWjhsSU13OEluVzJEdHVrRTBFbVdnS0htWkt6R0I3dnV1bkxQWXBucnBs?=
 =?utf-8?Q?yS42s8Dq1CJ7HxEiiXOdnd9exZ+/jhg4iiIgzC8uFTho?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c21b964f-2b51-4331-251a-08dbaed9f7e1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6311.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 13:05:39.5192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmLMuYkeiwevDVDphJziM6KcOcqB8ABbLgql40I9oOozrCE7WK6kdzTJwbi7tlddVpnMpb7YdThU26QXUX8iKAcoTJ8qMTdFpMgLd398j3ZH9AZ/7XG7KLYNPhdZZFC7O/EcQlrm8sIfStiYHoe3Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8779
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01.09.23 10:06, quentin.schulz@theobroma-systems.com wrote:
> 
> So I very much assume we should also delete those two lines in the 
> simple-audio-card,cpu node?

Ack, I will send v3.


Thanks, Jakob
