Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304698005B9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377862AbjLAIfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377869AbjLAIfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:35:40 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF871712;
        Fri,  1 Dec 2023 00:35:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAiunnPWlsfaLzTkk9ZkV6SqhxxOYOIzOQEo/f/upLXUaIbnKYi/BMlYjUeHUyf6bdIs9M5mfZWJPcCZyvVd1pyg3MuTcPq9QClDTXalAt7qgJ11EKmzzLLt2aS1FyajEAmspddec7C8EMA93YiOmqZrcj0NQEKiRbnCg0T543EtOcfgCqegDJG4PRdI2ZgKr0X1MRoFi5EIbvgIQYk5O5DyXKT+VWLiEAi59pSGBkZiL2wPJdxNqmcH229qUnh1oVKRuBo2Qv5V+JCNYWRxnK8Zywyf64BZgvarg/4NaLt+878MvXnZG+vRJyG3gaM0wQiGN8XoOdVgNdBc7B1Sfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8VoKZ7jT+CXk4KBdgICnCXvuUsTbs3nEJgDXMMDUO0=;
 b=Ux0t99j/etLTM+SVy25HMu6s/yFxhtpx8B1FIgPL3Jvs50l2KOuS1g/8bRSPuuOJzye0qMX9OEISotKZHgwpYuB6QrRvEvr6cS2M6P5ssIpy5MV4i49eLdgQirmsnNWg13AH9Ma7M0tJVS9H9IT51fHacXlFr4AhKeNH4deaEY8loaCD/qwfjbyJOC2RB8QLquA0aXRxBgFEkdUMxyc178ZOHebfiTcnsPb2KZ4aqXwiw+J2V7aYzz/IAwSWJu96b/5U6Uc27awx1GVnT2+r6SS1QbT7aURZLnKTWg4X9sDKDROz3AochE+te6V8UtqMt4KkaGHTIOR+zjhwfnvaZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8VoKZ7jT+CXk4KBdgICnCXvuUsTbs3nEJgDXMMDUO0=;
 b=g7HKaJl8VFGwpAfKrqfoxixyAdh+ndw+RNZMEPBZp9afqHlf/EgxkU7R6Cj8RNDCkdPXhiacHFcRVDA+Q0tLIZtve88F7QipHOfX/sOJiHHPHGUDTtStZV0sCzjGtXdZsB6DaNYiTZ9dpYx4WgRg3MyuEExJ7ZNAM1fLJplc+D0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by IA1PR12MB8078.namprd12.prod.outlook.com (2603:10b6:208:3f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Fri, 1 Dec
 2023 08:35:44 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 08:35:44 +0000
Message-ID: <074cb071-2a3d-4c9b-89ba-d215a3624b6b@amd.com>
Date:   Fri, 1 Dec 2023 09:35:27 +0100
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
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231130-power-rubbed-fbf64a8c6978@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0102.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::31) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|IA1PR12MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: daf62a63-98a2-4b74-a9ae-08dbf248821b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zegTtd3HDq3y6kz7xbPNC2YFBagC3JeSXl9v4X91yxSgJPSkN7vEa4xbp7EHWvTYIm80Nbt5DueLvMeAhRlzgPIroIa5xvxZ3b1amR+92inpDjJC1cmBGpkrS3dIK7b3fjMITVOrxXgiPBmJLk/uDTFuy2x6cIT51ggQepXxu6rsgM8cAqBek0A0GZBPrqehxXBLRHcH8qV6Z0SiRRZghP+gJcmE9sjkuPSPQjKYPcLJO5G8VeYvU1Shzkobli//uv5gnOPyooBOy6IlJtctFzj96VpvUENSQORwu8bsPgTI0s6XoYAz6VFItegMVepKd4d/sAcVIFat7KGqoXlIyETIGc8SqwhQXaEtAPFbMkoUHLSFQYnyzfiIU2k/ibNcswi8llK7zEnvSAt+LVro94i1u+9Z/vL6S6KJH3yEMt6Vk3a6U+r+oj/d+wlq2+dmD2IHUeZ7KdTtdmIn2xB7bqJKE+J3h2FLh3itk9REQf9Kg39Pkq07ZqX6ez/bfImBmJgR4NLjWhvqt/SCxAKJuNv0nkJooBGltN1BdJMwS/VDLYfYXOmCM3RUX/rNL2Yp7Dhumbi4MgSCLgATOVQhJXUrw9Ap39TzXAMRH6vLjf/MnoYB+t8NnhMPt0pH56RMRzyrNlFAanItXPLFwzoQwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(38100700002)(31686004)(83380400001)(86362001)(31696002)(5660300002)(4744005)(4326008)(2906002)(44832011)(8676002)(8936002)(316002)(66556008)(54906003)(66476007)(6916009)(7416002)(66946007)(6486002)(6666004)(478600001)(6506007)(53546011)(36756003)(41300700001)(6512007)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWRxYlFpQ0s4SnhhVjVCeDBMVWhoVjBaS215Q1VJTjYyZlQzMHZNWExGLzFV?=
 =?utf-8?B?cVpwWjA5ekd2cU9PdURTRG9qTjdLQ25YblpmRmw5L3JMYTlkR0lXMUN3YzU1?=
 =?utf-8?B?c0wxZGhSMGp4WkY2ZlpQYy80azhiY3Iyanl2cFJvZUYvelNHK2hiK2g3Wm9t?=
 =?utf-8?B?U0M4RE5pOHpoSzh6Wk5pNFNoQ0dWZHYvNndxT3d6cms0b1ExZGlIK3NrOWtx?=
 =?utf-8?B?b3Fwem91amEwSU5odktzMllkcVNjbnh2N0hXclh0cndaL0lOait4WFZlbHlJ?=
 =?utf-8?B?YnZnNnhJaWlZLy9ubGpWMlhteUk5RGp6U1BTTW85UGtYelQ3UnM2MFJnV0p6?=
 =?utf-8?B?LytpbEppRWptbnpUVkY4NndSdXRKcFZ4Z0ZCQVlWUHY0d3dJQ29NNU1qNHhY?=
 =?utf-8?B?eC8rR1VUMXpRRWk2cFlUSE0rY1Q5VnV6Y21waGpMVUFDWUVPQ0pFclpXNVVK?=
 =?utf-8?B?WW9EK1lvMmliRmxHbTd5TzRTUEoyWlZQdzM5ZC9OT205WERxUmM4KzlWOGxP?=
 =?utf-8?B?SXBMUW9HSGNoWkE0VGRWaXdOenVhYmVDZ3NTMDBOemJXdlY2ZFVGNytXcDN2?=
 =?utf-8?B?bWJudi9wMzBtZjFrNWpmN3pjRjVHV1ViVUErcmZLMjNtL0IvT1hyM1lBejZN?=
 =?utf-8?B?SWZWeE1PQUlhNmJPRFVuVUVQdjlCcHNENjRMaUlHbHpZazJlcGMvL3RDUWox?=
 =?utf-8?B?RWdxYTAwaHYrL25MSjZRcnpkMzdGbnFESjVaMHYvU1ZYWDhnd3FldU04V25I?=
 =?utf-8?B?RDJDUm9ia1ZNRkVGVG9JclIrK3J3NGVUeW9XQ25NRDlyU2w1NzRSWURMWEVM?=
 =?utf-8?B?SHJzbzJVWFZBVmpOKzNTRSsvbXlxOTVuamlsMWVkWGRSajhmVXZMTDUwME43?=
 =?utf-8?B?azNrcDJKWHpldVp6dWF1dVVPOE9YQTlHdmdHdGZnTVpoRk8rd0o5TTlFeWZX?=
 =?utf-8?B?dlB1OHlyM1NVbEE1NW1ZUGEzMFA0ckxjc05nYUtLNXV4dWRZQ3BheC8yTko1?=
 =?utf-8?B?WWoyelNXS0FsTDEwNVNtYTlOejR3RldMMzhGNm12UmloUkFWTXkzc0VkS0xX?=
 =?utf-8?B?SENOZjZYRXdaTGM4RkpPMnZhUGV5MWFGU1c3dmY3Y05WbCtVR1lFRFd4WmVK?=
 =?utf-8?B?RHRSSjdZN3VRemFFa0tTWVBQRFdLUm1RVmpCajh3aitiYWdLQitnTGRmaUJN?=
 =?utf-8?B?cmYzVFUzSGp1MkFHb1BpUVhXU3pNRXh0WStHU1JOYzdzS0pRVjdmZWRaMnA4?=
 =?utf-8?B?OEdzNm94UlhoMHR3ZkZJeCtWMGJnTFU3ODVKTXQxQzYzL0hWL2pkOTZMNXB6?=
 =?utf-8?B?TzF3TjZOWHMwY3pxKytibnBIa2I1K2ZKZXMraHZsenZ0RDRmbU96TVVDY0VM?=
 =?utf-8?B?aWJtUjdobTBwZmk5VnVOWE5hOWNZSUR2SCt4RFhOSFluc1pWWGszbDhvL09q?=
 =?utf-8?B?ZUcxRmNKOHNQaG10K1F3dVhIazQydEUwelNvMHBaQjNkMHcrVDJvMEp1NzJt?=
 =?utf-8?B?TlU3Z0ZTT1Zma05NRi80R1llQXdHTUltSHdmcEJybnRyUWVML25QdFVBODBn?=
 =?utf-8?B?aWNORTBjRmk5RE9hWGg5TFBTT0lOc0xiNkpGcEl5a2wrTDJpb0ozdWZwYzVT?=
 =?utf-8?B?WjNvd0tXYVEvUmd3alV6Y204NnQ1OHJ0ZGhVLzdJRU9OZnAwVEFPMml3U29L?=
 =?utf-8?B?NlFvMURKOHFpaXZrTEhFbFVtVjF3WFRjU0dURDVBSk9OdjhRNnlqWllnSlJI?=
 =?utf-8?B?QUpGS01qTGRuSGhvMFpZTE9ENDNZS3JaNHZwRzA4NGtub2d2c0tXM2ErdU9m?=
 =?utf-8?B?UXFqNHQ0RHM0QnZjcGFmMzh2azV0Tzl1Vm5uMFYrK0FHb2haSmk3cWRaQ1pU?=
 =?utf-8?B?cEd1dloyOFA3RDhyazBmaDdvNWhJWTdxbFJqdnNwV2t4KzlyUFJHTTBXZUxP?=
 =?utf-8?B?MFpqL2NiOTRoZ0trZDY5WWN5T2JJZ2paVTRialhmbFN4dTQ2WmlyYU1mcGJ6?=
 =?utf-8?B?TktHdTV1clh1T3BEZFgzdXJWUXVJS0p6U1lyMlZoMS80Rkt4S29UeE5EbStY?=
 =?utf-8?B?SFU0cUtJdXhTZXd3Y05xeXp4SUlLSm1mdTc3N1d1WnNvUVlPSmt4SnIwclph?=
 =?utf-8?Q?KT3rIC746HkdW4iyqnUyuHcWo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf62a63-98a2-4b74-a9ae-08dbf248821b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 08:35:44.0053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtP4CaqBsfO1bD5SFRmdiVpWmOr0lQe0PZ9loBLzt6/oExTUvyG1RYNv0s+O4tki
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8078
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/23 15:58, Conor Dooley wrote:
> On Thu, Nov 30, 2023 at 09:46:54AM +0100, Michal Simek wrote:
>> arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts is defining 30 channels
>> that's why increase it.
>> But AMS binding defines 51 channels
>> Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
>> that's why increase number to 51.
> 
> Please write commit messages for bindings in terms of how they relate to
> some hardware. In this case I think it would be sufficient to say that
> the Analog Monitoring system has 51 channels, the opening sentence about
> the dts as justification provides no actionable information.
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

v2 sent.

Thanks,
Michal
