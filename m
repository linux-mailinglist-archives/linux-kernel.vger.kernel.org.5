Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A5C802C89
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343644AbjLDH5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjLDH53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:57:29 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447B6B9;
        Sun,  3 Dec 2023 23:57:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoDwSsHjbFdVf5777snjQVIufgvy95vwr6A7WNAuulhvIxAjlhe/gFPuJIuirM4717lxiqT7yUq1sKqTkTwEwX0M7yQWLN/7/ff/kxaStov/lfjhaQN3E57T3HaHSsaAuYNL8NlOceejukafMFc4Js8oGEWN4XQ6UkeQ4tRMh9C+JblscnqG4nQbzhy+zPB+XrFre3vJpxLitZIfc8ZFdOIpqor67vL38FxbbMf4cDOEjEP2NSVfN7F2btFURVa6FgbqJIUoSbeH2rE8DtrgpqmBrTZey09mB/vGnq32rZxq1zMM55nelhRI+IIC1bs2K151mYwVNIMSCdfw+R5gnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ru1S53EoHxDUFYZa3XhDYN7m63JwLKEDFDgsydFtKIU=;
 b=cYbEJ+bGmY+MCuLfYPf841RMNNtkg7IB8Wgo4ih5HwUbnJAJfuvapMtx91nC/usAOoDTENExds2NjgOnNQ2n1eAzJDXJbsmbpNVhjOzaHs6ciPHbaegNIx9K9mP7ePmmOFF85YPbrC4qsfnHH0vFv5q3C0Qiy+URQSpnT6UxsLVaACZYAcWtt7o8cB8fO1loc8YeJ3L/Gg+cb8LFWtAzt6XDD0zmMSbP0wITu2H+yliXQe1P7xwHpw9A71ZJ4kd4VDH6dyH2uK/FzHLuAak0uFsra5/hARdp/cqVwnrf8LHeUlopIoc7Spfl8s0JncM4wI2WmmB7muaWWBPTcK/tog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ru1S53EoHxDUFYZa3XhDYN7m63JwLKEDFDgsydFtKIU=;
 b=4fZ5DMUQZM7TsYkfguTVNxUyXeTWBeNuJHQBPHEzQ5+VcdNd9omj7tIBua5WSBfoxjjc3j3C0l+Z4q4FSBeQNP7Up4No1Fyglwks10aNNlCqnMY0Op5NydnwM2WXFTtJgsp6/kA6PSYseE/A2J+Ch8cJgxVUzgcOm2B/SsSKdKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 4 Dec
 2023 07:57:33 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 07:57:32 +0000
Message-ID: <0ca586ea-ba5b-4574-a93c-d92d930214b1@amd.com>
Date:   Mon, 4 Dec 2023 08:57:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: hwmon: Increase max number of io-channels
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <441d9babc7042892350a58ba4300df4761876ae3.1701334008.git.michal.simek@amd.com>
 <20231130-power-rubbed-fbf64a8c6978@spud>
 <074cb071-2a3d-4c9b-89ba-d215a3624b6b@amd.com>
 <20231201-spousal-outage-c8c5ec1fca80@spud>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231201-spousal-outage-c8c5ec1fca80@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0296.eurprd07.prod.outlook.com
 (2603:10a6:800:130::24) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: b10b7cc6-5f2d-49a0-8a83-08dbf49eab9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gNcv7LzTtNljJyfNGJ53FAD7hMulz/0//yVh/7cvTVCHkpGzOeM7DIAUtSsXjmCa8Kg1L93W94VsW2QV+I/ePFm01vLrUdwMLc0Fndq1CxA4ZN4tSesU7i3xFVyJZspBY0mdZ9QLa7zzYCJ43TACXGVpj7VoCjH3/GWUDTY59BYGkEpbVdt09csWjgYP/z4a3cf13UXCyblOKL10mtdw+oxVOINpTRIKQuDPJpn7c5pZw79ak97aMBndDTzRj9eyGjnoejLy9zcXt6E6qEws+NpsBbhDm3PdhikVEKtXBG4ZILkCiysHUvFGS+GEbzqmFLfpNXgMv4/AucAf9pFhhPJMPQ3/Ms6BfPTQef+F9ejXTK8ZpYLYJnRIiVffeiP1VsmzXWDHfZuAQq4I619rGHffUgydTR3ClYc0s+yxa7K25f6J7/K6IOJ1oisNgzb2rtaBqcezUpF5U/YKzaxiE4Xb69dtEzNrd2LdW8NA6hm6aAqkB4bxk+RzyOm15cOn4F9yxatrq6/+YrykfuxNiWunwSfcxtyjBH48Dta8xbj9XhGH2PIYKjESuCg+OqHP1QyGd42WaEGoXb51BaeEt54apvAsO98CYzMhZNRVxPeIAkEZjazjUl0VCU+XjObUgVjNYF3Hm3EB1VGEw/GLnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(8936002)(8676002)(6512007)(4326008)(6666004)(6506007)(478600001)(53546011)(66556008)(54906003)(66476007)(316002)(6916009)(66946007)(6486002)(36756003)(86362001)(38100700002)(41300700001)(31686004)(31696002)(26005)(44832011)(2906002)(2616005)(5660300002)(83380400001)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW82QkxUblRQQ3kxcTQ1MHZlV1J6MU4ra0ZNdWlqSGtmVmV0QzVlSFZNcjFF?=
 =?utf-8?B?ak83NkFmSEthbFZSWU5VOVdSckQwY3lEYWVVSmM3SzFJQ0VxbEVnbjZBSDgr?=
 =?utf-8?B?Q08yck1lRjR3MVZGRG9RQzRNeXB3d3Z6Tnp4WTViaitKMWZUS2Z1VFFVSXV2?=
 =?utf-8?B?aHA0K0RFKzJtYmNZMHQxL3dNSDVFSDVoMU9wdis4bStiYzV1dkE3b21yazhF?=
 =?utf-8?B?N2dGd3ZaUmdnRWljTDdvdk9UZE83R2V6RDU4Rnc3eW1LdW1XaGp4aFNBY2JT?=
 =?utf-8?B?dXJqdk5iOWFZNVVLUmZGUEFqYloyd0gyVTJnWFpucTBSTENad0ozdnU4Szg5?=
 =?utf-8?B?bkJXZ0dhQlhwTzZmZFRBRXZJR00vRHVlMThkRGhqbFdES0J5dEg5Y0RReVFT?=
 =?utf-8?B?QmdhUHk3VXQ4bDZlTmdSbzg1U1JWZ2N4SFBockVkaDVDak9kRGo4VnNKaGp0?=
 =?utf-8?B?aUdKeUxhZ1lTd0VlKzVLRjBOcnNabWFtZGpwMzFJaEpNV3lzN0YwTG1DaXgy?=
 =?utf-8?B?YUg0TkhOTTVPeXZnMG5LeUppOThjaWorRk9acWhGVmIwUVl4elNYZDZPZ1RT?=
 =?utf-8?B?RmlQYXFONk1YeGh6TVFNK1JZa2VmcENnWmNUQ1htb21QMFBmQW01aThyWkRz?=
 =?utf-8?B?OGFkTk8vQnpqUGZXemh6TWhEcDA4RWJrME4xTGtaRkJlTzNSVW5IUTFWNEww?=
 =?utf-8?B?SWhEZ3g0TFl2VWdSMDZyaytKcmRyVDRnSTRYc3BMM0c4STRiM05HZ1RoTTBF?=
 =?utf-8?B?dE00WU5wRnZpMFZyc3l3K0dZNjFDdEQzdVlaUHhtdHlnWklqRG43TzlQeldO?=
 =?utf-8?B?ckpOaHhnT0tGYjgxRlljWk1SSWFBYm5xeDIrWXRvUFFlSVowRDNrM1VBT0pl?=
 =?utf-8?B?VXQ1U3h4MlBTQWpYUGtqSTdTMk9oZ3VpVDlLdEVpWHFuNEd5Vmo4d1dBTEV1?=
 =?utf-8?B?R1hzTEQxbDcwdkk1K2FDZG5SRUltRS93R2w5M241T1BvQUVFUnhFSEhTTlhI?=
 =?utf-8?B?K1MxbWxHcGhUOGxzSVpBdDA2SlB6V1plRHhwVld2NkdQcEd6TTd0dVYxWHhu?=
 =?utf-8?B?cG5GRER4RzR5TzRNY3RVNUUzakU0V0pvNi91d3EzajgrUHJUbWV5SGZ6S243?=
 =?utf-8?B?d1pDcjlvZXV3a1hieCtmQVBTS0RqSFpYZW1TMUxBNTdYUEVSWlJhUGYvZkxx?=
 =?utf-8?B?d2s3dG12dkI4UlRhQUlCdCs2Y1JrNWZaMG9WT200SFZtdW5iLyt0NEMwdHBN?=
 =?utf-8?B?akQxUEpNYW1rWUJQL3RDYUN0eVRMNWs0OHo0dldPYWFldHNHemZRd2J0cXhZ?=
 =?utf-8?B?aW5JYXIydUgxMFBvSG9uZlJCUVY3ZXF3bytrS2VGQldUWVV0aGpTSFVTV1dj?=
 =?utf-8?B?TnhBMWlNbVRxYi9ndlp2eVlYMDVORlNuN1lzanJTdXV2SzBvL3ZqSCtpdVBP?=
 =?utf-8?B?SExadDJHUmx5dkhoc0Ezck5mczd5RjJ1OE13YVZPazNtaXdvME9wUjFSK3Vk?=
 =?utf-8?B?RnhxQnY4NzJDajJPNlNJMkRlanYrZHViUjdNTmFRL0UrU29KR0RWc0ZzOFAv?=
 =?utf-8?B?L3dhNDhDOHhzdGpjSkJEc2hRMVJmc0VzaEVMVWdxVVdUTUxUeEQ3T3lpQXRu?=
 =?utf-8?B?ak5qcjNVVzVLMklnTHdZa3lnL0xDckhyNnQ4K2svcXNweWJoWHcrME56WVN6?=
 =?utf-8?B?Q2NhVWIvdU5wRm5ML3UxVTJjT0ZQOE1lUEx5NDlWbUIydXJGMFJrWUZGTzdt?=
 =?utf-8?B?WlQ2ZGJ3SjFUSXJlcDR6bE1TMHBuR1V1WDQ4ZXdRempzMko5dldPcDVvWnFP?=
 =?utf-8?B?NElRZGxuUWxEM0lFdzZUVDdiNDhOY2pqM3Zlc1JRdGdxSFpRdXIzd2prQWUx?=
 =?utf-8?B?djcyWUFKdGUvZ1BxZDRMSTVBVm9CWjZtSklRSTFrU2F3M2k3dHI1UVpKejA3?=
 =?utf-8?B?alhUcXJFZis3aUE5YWxXZW4za2JBTXBmcHh0eHFZQWhTSldUSDU1RWFCalBu?=
 =?utf-8?B?TFRpYlJSQ1NrUzkrSGZPNGtRL1VwcE1xSW05dHdwT0svWHN4dS9QMXBtb0hG?=
 =?utf-8?B?RUhDQlVYZmNLRjlyVWVhNEZubzhweEs4amUwVkpJWC90d3d1VU82RVlaQkh5?=
 =?utf-8?Q?Q7srzgRi88uOvSh7AH40HbDPp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10b7cc6-5f2d-49a0-8a83-08dbf49eab9b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 07:57:32.6811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+Ajl8Nv4wvQEtdCVRP6PKxLkKH3S4m8d/Mn33oyUP5yaNiut2OpahyDYhSJ4kfF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/1/23 17:07, Conor Dooley wrote:
> On Fri, Dec 01, 2023 at 09:35:27AM +0100, Michal Simek wrote:
>>
>>
>> On 11/30/23 15:58, Conor Dooley wrote:
>>> On Thu, Nov 30, 2023 at 09:46:54AM +0100, Michal Simek wrote:
>>>> arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts is defining 30 channels
>>>> that's why increase it.
>>>> But AMS binding defines 51 channels
>>>> Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
>>>> that's why increase number to 51.
>>>
>>> Please write commit messages for bindings in terms of how they relate to
>>> some hardware. In this case I think it would be sufficient to say that
>>> the Analog Monitoring system has 51 channels, the opening sentence about
>>> the dts as justification provides no actionable information.
>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>
>> v2 sent.
> 
> I wasn't requesting a v2 FWIW. "$file uses 30 channels" rather than
> rephrasing it in terms of the hardware actually having 51 channels just
> annoyed me, that's all.

I know and I agreed that commit message can be improved that's why sent v2.

Thanks,
Michal
