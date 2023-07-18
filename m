Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A448975750D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjGRHLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjGRHLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:11:02 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CB31A2;
        Tue, 18 Jul 2023 00:11:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3sSwQvFbCjlUQNqUgHQ22zEOHWuJ4wydnqadavu9phPnIFHKbxlPNs+upIvPlQgF8hTQvHNGdBDHFuJHMBmuK5gjXr4QZ3vVSlw9JeWpb1bfQWZSw1lsUxSPeI5r/2cMJZ0BxL7eaRU+0+KWmU5oSKXlorRWyS8vrdXlAeIrawa56bUEmp8l+PBT2ECGG+HkbKeSeiZD+rJIgQVb883WzBwZiUl+wBVr9Ia2sywnhTBYVqX8a3qyChNIKLH5Msmvr/BJeHiKGOnG30nWz94tUXmfOrL9CAywxzQVP0WE2AeBzDoWTfE9ALs4AoEK+JKKpfBVAFQMorMaQDPenLRGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWF+4PhLbibGkeiEMBAO1vv9QHFSRhA9GQqMu6Q8PP0=;
 b=FjlXFkfKr34rNWCW/j27k0pcZMUs19YIK7Z6R/XYIFxVEiQCyPrNGLWY6iqSJ//n1C6aZd+4df5VkwGZxOlcOxsAs9iWPOHl92HB85+OALDVVTsUQCcZg3h/1gMfvQnbc3URC3VUc57kfnX7P0RNETYNPVb1AStFkZDbDPGE7XboK7Jz1xHx1TBRu166X1Q0LlF2RUAGxDdVEEGCBLsyzWZTW3l852m7RuBvv2CYNpWylCKzbxnJwUSZMQOoJO4Ye3E7E20AhFEwa+ktSOxCke8+GurnRdl/5svc+dX86cOqR51FQuL8TJavZ1WJZ7tlxdeQNCDNtOGzN80hYMZwNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWF+4PhLbibGkeiEMBAO1vv9QHFSRhA9GQqMu6Q8PP0=;
 b=AW1cyEUxkKiILp8PqxY9nhrcpkn8vnVAcjx+leVUCaYpnKOruoFwwAjXsQ66kB9YUOW4aPfCOtc69kudA6D4Fu+RhHH7hvQKFgi6h3wo5ApxvmB5U13itG28LO31nMpDT1Nd8dzCelPs6Ilv29hSfMlGHVqdUslRzCa1LVb+LLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 07:10:58 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::be39:45a4:cd9b:4684]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::be39:45a4:cd9b:4684%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 07:10:58 +0000
Message-ID: <e8f48a30-9aff-bc2f-d03f-793840a192c9@amd.com>
Date:   Tue, 18 Jul 2023 09:10:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Piyush Mehta <piyush.mehta@amd.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
References: <20230717112348.1381367-1-piyush.mehta@amd.com>
 <20230717112348.1381367-2-piyush.mehta@amd.com>
 <20230717-explode-caucus-82c12e340e39@spud>
 <ee81e955-32be-66ea-377b-263ee60a2632@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 1/2] dt-bindings: reset: Updated binding for Versal-NET
 reset driver
In-Reply-To: <ee81e955-32be-66ea-377b-263ee60a2632@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::9) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: e2fec4f3-5892-4924-69dd-08db875e22e0
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QCcoWx5sVx04YSF3jJ+k0F+FGS1b2tCP0nZhEyWkoY8k8/kAhZYGJts5WD9GHhe7tNhyeQDzrLTH0+iX6L8TARa/aq5XTyWtEVFYCONWl1q57Lh+GXTYXTqcQWmxxTGdhzfMb072hszCU2mLS0ocsVuQfyxDp/kGaJPXwYdhQvCoWP54CJyjfDOGr/m691dMbtFDVFPIqsUKvGudHshXAXnWNorcCCQVOn11vVjxnIeBSqRT0u+FwsDFJbrnP6fQzfdSx6uo6MeTQWuRTpHMi0ykNwgTK3vIwUfImLmkhVlLW2Q0c9m2aC2XuMdKddC64Y33YNucWj7gReNARVMZRUAAG/PhR1z5rqHL2AqauqxRQ5f7Ibi6zg/ZSe6TToT8xFpArpA/0PhFplCY93rTFq5V+HG3lvX2LnQVqN1wpEPoa9kbY6alLauP7dq5jjYu767oWNQ9Z0uZItsriTyY2Rkmw4Atwos5GhHvmVZEqdv7K8puuvJ1H2Dne/L0CtVE9Bfqu08/ocAwD4aY4JFOduhLvePT4Xo4VOP5TBaVADsN1Kqc87eUNv/wIKZf7bnC90NFsSx0tzPBiRxmMIV7LcDw9g267ZkadhflVdAAwwnFivbHKLgjR9RNeulIVFzFQRln0tX5a1FXH+YcsvrUib76xze/DUcCeGANfJZmTnGINURgPs6qW/Jro7zWpH/+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199021)(31686004)(86362001)(31696002)(2906002)(36756003)(44832011)(6636002)(2616005)(966005)(6512007)(83380400001)(186003)(6506007)(26005)(53546011)(6486002)(38100700002)(6666004)(110136005)(4326008)(66946007)(66476007)(66556008)(5660300002)(478600001)(316002)(8676002)(41300700001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WStLUnpEOFB0SkUwWVB4ZmhJeThwSGU5Vkc1Z3FmQUx4RFRQa1VmYUdEc1F6?=
 =?utf-8?B?OENTeVFIL1lxdnd4c3BuZytLQjlXMmtoamVvSVdPaldqdk5aNFFPR1VlZ1d0?=
 =?utf-8?B?SHlPaVVMem5BZk9kWkJVWDJYeXRMamdIcWpRS2tHL01HalNEcm1pSlFsUlpS?=
 =?utf-8?B?anIzMFhiemFSUEs5bXFlUDJXWVIvODhFTGRscTRydmVFaitsMVVSdnJaSENR?=
 =?utf-8?B?dGJQSVoxcjN5QytEQUNkUzQyTU51SG1MVnU0S0FRMXd1STgydDZkMVU1dzhG?=
 =?utf-8?B?ZXIweFNpbHYzVlkwVkJJaXprdWJEMzBFOEdRS3RBclI2a0x1Q0M1bE9BZHIr?=
 =?utf-8?B?T2c2cFVHTXo0K0o3WGlzY0M5OVBkSklodGJsV3RYVnJxK3d6Vkgyc3BEazM2?=
 =?utf-8?B?eko3MnNaWCsrbEJ0bDNoNEswUFpyUzZQNmdkKytYbjBoQUtKREl5MEtyYzBY?=
 =?utf-8?B?Nnd6cVZwQys1UlZzdUZCWlN5MzhmUzdLbWwzWm8vckF6Z2VEWlZDc0VUQWsx?=
 =?utf-8?B?dWxOQTI3VmtUbUZDQXg2VU55ZFUySEhCYUdXWXRuS3VZYXJia1hDaXRkVnE3?=
 =?utf-8?B?SjY0c3lvc3ZDTUNYZDVmVHM0RXc1MTlvTEdkS213djNUL2c2YlJQYTlRSXpk?=
 =?utf-8?B?U0xsdk5ZTEoweUV0ekhSbXVKajJwS2szL280dVNvODNLWTRTWC93bkk5blMy?=
 =?utf-8?B?Y0NwS1JIdzROYW1ZaDRWTEpZTEg2N2FjakpIUDJCL2MyZEhWUHR1eU5pQUFo?=
 =?utf-8?B?ZkgzQ1ZqQW5TaWhNS2FqbHdxejFtdXllR1NsZ1dKbHhCT0dpaUpub09pbDly?=
 =?utf-8?B?SkJMUU0rR0poTnZLR0NTbENpTmpzV3E5NnVQV2VkZVZTaDhKWGxZRUo0c3Z5?=
 =?utf-8?B?MnZTOVEraFB4enZOWEg5Q2FFSHQzMFVucVhELzU5cUkybE0xbmhSK1o3TFp0?=
 =?utf-8?B?TzM0NXpHRWQ2cnVRakVacFd0Und2OFFUMFRKaGZnVFVWRjI2QnVoZmJlM2JT?=
 =?utf-8?B?SDBTbTJwZUlGQ21sNENqYmhVMUxvR0lvcjhWQXJEdW1Yc2tVRU9MOE42U0VV?=
 =?utf-8?B?QUYzbVdSWkFaZWJLWDNWZHBJV2ltSU1Udm50RGFhTXliUnRYMktQekYrTit5?=
 =?utf-8?B?M0RXTGJ3MEhuOEZWT2hsR3dmTlk4VXRwY05vUU9MTFFsd3I2eVBJSklUYTgr?=
 =?utf-8?B?YXNiNDd5cTVzUGxqcnU0NFVFcnkvbFlibFIxcC9zeG9RQUVHd3VZQXJUYnAv?=
 =?utf-8?B?YW9QUXVMRVVyNEdkM0puRGFXTXA3Y3lrdkR2NW5ZTXFJeW9qV0Q1ckQ0UWtH?=
 =?utf-8?B?WVllQ1g3NUtldFhzQU4rdDczUDVTVVlseTZoSCtLYWJ1RURVTjkwMk1qV2xy?=
 =?utf-8?B?MzZnTW5vRUtzMEJwMlVodkNwOTE4RFJndmJNZUpSbEZhSFVMUHFDd1lHTWZK?=
 =?utf-8?B?VlpxY3Uxc09HRG85c2Y1dnBodzRHQWJ5bWtsa2phUEJXNk1ubE02YTJ4Y2tt?=
 =?utf-8?B?ZW1uaENjdFJzTU93c2pkUUhCVXpaUmo0N0tlTjZWa3FxdlRtQ3pROFcrL29s?=
 =?utf-8?B?a2NZSGZXMmFoa0FoMVRBWWkyZElHWXBCSU5QY3I0MXBoVGtBejlUOHg2TTB6?=
 =?utf-8?B?TThFUWw5aHV4cVRuOXlIYmdRSDlwNmRQWVg2cjhPM0FYbXlzODdtcS9JWDZK?=
 =?utf-8?B?cnNHRmhRQ2JHS2lZWUtPMjVuU0NpdDJaTkZuSXJqYkRTZG9NTFI4Tm1MS0Vy?=
 =?utf-8?B?U2F1QUh6SExKTTRpMUxCYk9yS2pKYkVDdUF3TXMvVjBBVWdwTzFVSjV5My9p?=
 =?utf-8?B?OE9MMkhVRUh5UnlaV0MxZFVOK0o2YlhXZHJtNzI0MWRSUVROODdJS05JeStF?=
 =?utf-8?B?OTRhc1FxcFJTd3Y0dE1pNjhoY29jeGRBVnJ1NEo1UjMxWkNLRURFZjM1c041?=
 =?utf-8?B?SzlwaEh1c3lDbnVyYThGNnN5bVdHUVpFLzNkVFFOUHY1bmRlTjVkcUsrc1ZG?=
 =?utf-8?B?cHVzc3pPQXErVVlSREVzR1ZXMmFTdlRLdllWaWNITEg2cWFoYlFLdmpVL1Ft?=
 =?utf-8?B?Mmc2L0RyWE5OTFlvMGFaZGNvRGNJOTZzSzRJOXE3dVRXeVVwV2RUMG5pZlI5?=
 =?utf-8?Q?v0ta22y3ruCzwBb+WQ6bGP8xr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fec4f3-5892-4924-69dd-08db875e22e0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 07:10:58.8095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9ZtPScW05pPqFJ5NxG1BkTB3fxI0uXDG4D4QQ9ZRiZeZzUdS1VEbLmgS0AwPF24
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/23 22:47, Krzysztof Kozlowski wrote:
> On 17/07/2023 20:40, Conor Dooley wrote:
>> On Mon, Jul 17, 2023 at 04:53:47PM +0530, Piyush Mehta wrote:
>>> Added documentation and Versal-NET reset indices to describe about
>>> Versal-Net reset driver bindings.
>>>
>>> In Versal-NET all reset indices includes Class, SubClass, Type, Index
>>> information whereas class refers to clock, reset, power etc.,
>>> Underlying firmware in Versal have such classification and expects
>>> the ID to be this way.
>>> [13:0] - Index bits
>>> [19:14] - Type bits
>>> [25:20] - SubClass bits
>>> [31:26] - Class bits.
>>
>> Riight.. I'm not sure that describing these as "indices" is really all
>> that valid, given only 13:0 are actually the index.
>> I'd be inclined to say that the type/class/subclass stuff should not be
>> part of the dt-bindings, and instead looked up inside the driver
>> depending on the index.
>>
>> Hopefully Rob or Krzysztof can comment further.
> 
> This confuses me as well. I don't understand why do you need it in the
> bindings. Nothing uses these values, so storing them as bindings seems
> pointless.

Power Management team wants to use these NodeID with format describe above to 
identify that elements. And I already told them that ID (0-max) translation to 
internal NodeID format should be done in firmware but they don't pretty much 
agree with it.

 From DT binding perspective I think it doesn't really matter if numbers are 
from 0 to max or they are from random high number to another random number 
without step equal to 1.
And it is driver implementation detail if driver itself is checking that 
requested ID is bigger than number of pins passed.

In connection to reset driver in Linux.

Core has:
static int of_reset_simple_xlate(struct reset_controller_dev *rcdev,
                                  const struct of_phandle_args *reset_spec)
{
         if (reset_spec->args[0] >= rcdev->nr_resets)
                 return -EINVAL;

         return reset_spec->args[0];
}

/**
  * reset_controller_register - register a reset controller device
  * @rcdev: a pointer to the initialized reset controller device
  */
int reset_controller_register(struct reset_controller_dev *rcdev)
{
         if (!rcdev->of_xlate) {
                 rcdev->of_reset_n_cells = 1;
                 rcdev->of_xlate = of_reset_simple_xlate;
         }
...

And zynqmp reset driver already defines of_xlate function that's why checking 
against nr_resets is not done as is visible from code below.


static int zynqmp_reset_of_xlate(struct reset_controller_dev *rcdev,
                                  const struct of_phandle_args *reset_spec)
{
         return reset_spec->args[0];
}


And actually Xilinx Versal platform is using this for a while and you can find 
IDs description here.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/dt-bindings/reset/xlnx-versal-resets.h?h=v6.5-rc2

Xilinx ZynqMP is using IDs from 0 to 119
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/dt-bindings/reset/xlnx-zynqmp-resets.h?h=v6.5-rc2


but IDs itself are shifted by 1000:
include/linux/firmware/xlnx-zynqmp.h:217:  ZYNQMP_PM_RESET_START = 1000,
#define ZYNQMP_RESET_ID ZYNQMP_PM_RESET_START

static const struct zynqmp_reset_soc_data zynqmp_reset_data = {
         .reset_id = ZYNQMP_RESET_ID,
         .num_resets = ZYNQMP_NR_RESETS,
};

static int zynqmp_reset_assert(struct reset_controller_dev *rcdev,
                                unsigned long id)
{
         struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);

         return zynqmp_pm_reset_assert(priv->data->reset_id + id,
                                       PM_RESET_ACTION_ASSERT);
}


That numbers in DT are virtual no matter if you use ID from 0 to max or random 
values it is up to code to handle them. Checking nr_pins against ID is done in 
core but it is up to drivers.
In our case that IDs are coming from firmware and driver itself is just matching 
them.
At the end of day pretty much IDs in header can be from 0 to max and conversion 
to IDs can be done in the driver itself or in driver probe firmware can be 
requested to provide IDs with specific call.

Thanks,
Michal
