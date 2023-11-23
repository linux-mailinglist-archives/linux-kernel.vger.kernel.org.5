Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B3C7F57BB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 06:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344687AbjKWFQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 00:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjKWFQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 00:16:32 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80671A4;
        Wed, 22 Nov 2023 21:16:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FapedvklXTce73T8iiWqbme10SIufc8gVaXabillia1g84b2Hj46WLAxGPspit9Vtzd5d8w+FZP6/YmEQX3WluGBQgonHqC4noH6Vyi6X4zSwnV+H88QC3k2FfUmYjHeUj9ulsWjby90tFFgr7bBG3GHDzib5X1Qk2k1bxD8E8SeieZy8wCO6osCOuI6f/1WXcRYhzG38RRoHsYvlWpgZ9X2Y+E2mgdDWBQehOjo3F2DIQ2oD2MOpg9J3r92zMLan9DwQXav8RBtguRpRPB/3s+NM9Z0SmOFNxbcWOhZRcuQrjbw63jmXdjALJtCu50iud9FOf9mlAH5gz4QvQuyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsdC1otIOzw0pTv0B+KqPHIpR6s11JBYjULsyxviTJg=;
 b=ZAudMFMuqjlJSe3XZr9MOjU43AV4eI8aJNXxc0IHknbLCP3sLNvNtNRx6bOqdj5GmWT/97k0866wlwdtwc1dmQ41WGrg49NH54m6u+El24I3ZU4gJdtunZkGqAzUUnC/ZlpTJW76aegfgDvbDXMNd0uRW6lOw837buxCXtYpFjlfmSUmyLHlHIKRLY5ozUxZPz8BHRbBH+LGC9lbE/7vT8RKgN7o9419SdTvKxQZg3zO6EAz7Y+TqpQmJKcUnmqKMcHYNh0R2oXnlWfbQJyhmIuV3l9V1HU9m37X1D4uKRd8QYKh4ebhZWPgmCsjlmeclHGNdAfECX1POBeRY3Xktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsdC1otIOzw0pTv0B+KqPHIpR6s11JBYjULsyxviTJg=;
 b=WLapcT3kNXRQ7cp9K69ZDUiwXnH3r3LI+jEviPzukXnneogUr/6gJmuxnkFGTrigDzmI+f/TZYyAbJnfKyAC6piVHqnx64IPU0WkX/IQ9N7umJvZGoG6rLNqgpUg2bWtGC/GFh7qzoeCVNocDC1mCpOeGZUvsLwDpXNZqPAg3RE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 05:16:35 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::54bf:1f5c:daa8:e1f1]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::54bf:1f5c:daa8:e1f1%2]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 05:16:35 +0000
Message-ID: <efb152bc-fd17-a374-4303-20aa9bde698d@amd.com>
Date:   Thu, 23 Nov 2023 10:46:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Patch v2] thunderbolt: Add quirk to reset downstream port
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sanath S <Sanath.S@amd.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20231122050639.19651-1-Sanath.S@amd.com>
 <20231122060316.GT1074920@black.fi.intel.com>
 <95ceae27-f88d-4915-870a-36cf9418f244@amd.com>
From:   Sanath S <sanaths2@amd.com>
In-Reply-To: <95ceae27-f88d-4915-870a-36cf9418f244@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::11) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|CH2PR12MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c7287e-b66c-4e5e-ca66-08dbebe35cec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e8Gu9QFVzoQrivA1OfYcnm0WSG9p1iK5Ag4gXCEcmSXOk7OyXZkKgBpz5JOmpbq4+7HE2/CAyNTqru+CiQ9ke/K4PfB0VmKzmaZY+7P0gePMB9RyiNIWPMkoNzJcY05YjMrw2NnoC+JSLs+XcchC0P42MQNUwEOVkaA37RimiH0y7PnhyAGhk9+LFdd7TY4d2YKT3PLb7MefXbkmoEazCAs5jMIe5UP933BJuhYPuyg2fX8C0NNO+HacOL0t+IKZrMfh6jIibW2W3XgbkA6Z7ldwGeL6n48lNB2bQ0JonDYfFBU0AwvQO0WRyzDD1YPtRg2YfuYKvjwXcY6ZPGLLmas4Xi0VSMwnP6gcVh3sataGX0gujwGZS3fSYmVmErwdl6CQIEsHj6kuw5UOiq9EnPDIrcSV6Sq6WPGvlBBZznX9LoKCrE+W0bVTgT8zHooZ9b6IRvgweHoAosKtzc0eokP44g/qRqJnfGLd065kgUYKfAMxD9jkfAP6C+a4sKKIzEY+w/GPo0Fx3AouKuSW+u3VYQDJSJbPrYmHonoSMMBrHZkuosMq747qC9ms1BCjznQNCgflEzrfpzhmImorvLv/9PVA16d/eYiM/JaSycvieMOIsKaZjuYaWs1Fn6elPRXp0gQGpI5C9tcn+uyFBmQAQrkImbuoX2LWWURJD57cJxPHWVTd3mwae4LqMIH9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(366004)(136003)(230922051799003)(230173577357003)(230273577357003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(36756003)(5660300002)(31696002)(2906002)(53546011)(6486002)(6666004)(478600001)(83380400001)(26005)(2616005)(6506007)(8936002)(4326008)(38100700002)(6512007)(6636002)(316002)(8676002)(66946007)(66556008)(66476007)(110136005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXd2MXBoNGJYM0JaNlA1SkFVUStzMGdUKytPVXdHT3R3ZjBnemFwTnV6QTVV?=
 =?utf-8?B?bmZEelZINUhza2VoaHBzQnN2c0hCTHUxY1hxSnZCUUJnNlViUFArd0hUazJF?=
 =?utf-8?B?bjlINDBueTZFR2hEV2wyY2Y5OFNMKzAzdDV0WGlzKzlCdFZkVXhrS29BMnhv?=
 =?utf-8?B?N0lIMlc0eDkzbHdFY1MyQ3lPWUNmZjlidSt3M0xpbEZSKzliSlhMYW9OY1Zn?=
 =?utf-8?B?dnRXZThoT3dYZ24yREc2VUJza3pSbnA4YXVjZUxZemduUlBIN1FxRnBXb01l?=
 =?utf-8?B?ZWlBc2srVE9udS94TlRZUUJvSXpuR2NiR1JLZHV4bjVCS1M0L1pqS2VWeDBw?=
 =?utf-8?B?dXQranZ3QktZemprRS8xTEFJWVdZZnpVRllVN2RwOHJ1Q1dtMU5YTU1PS0Jy?=
 =?utf-8?B?c1hoMTRUUVVvYWRaUTlPK3U4dDA5WFRQTWF2dGdrTVpxaFhiM1pWZHU1N1Ri?=
 =?utf-8?B?dWovNTR1cEdEQ3I0WWZwbVR3TnJtMlA3bmJNc3FSakFkcklFejNqR3pSdmdk?=
 =?utf-8?B?OElzQ2VjSk9IUit0U2p5bVAxbTFXd2J0em1uN1NrOWZRQklZOFJIV2N3Rmhs?=
 =?utf-8?B?N3NkRGQyZkMzY0QzSnYwUDh4VU81alNmSy9PQzI3R01DVGpBekFPTHpYdEVm?=
 =?utf-8?B?SlNyYVBMT0VvSUVoVkRwVzhnZUlZMm5seWdwV3htQW5TanduZUZScm1rdzZo?=
 =?utf-8?B?TmM0Zy9HMGcvbzFtTUlJWGdMejVkRFlvcHFVV3lFaGFLbUJZK2p3bUg5TlVj?=
 =?utf-8?B?b2NYd0g5SS9qUmJTeDAycUk3UGJMRmN6VHdpc000ME1Xdno4WVhmdnY1RURY?=
 =?utf-8?B?VFFFQ1E5c2RHYzMydDFlcTRJMXgyOFFtWEhhbjFML3Boa3doaUdRaE5Md0dO?=
 =?utf-8?B?bXFMZG9GSjBKMTF6UHZWN2tMN2Z5KzhLTG5kc0lEb2VSc3hvdC9RckIwdmFp?=
 =?utf-8?B?OEh2UGwrYVFsc051aGpsV0lRMHNjWCt6aWhlSjJkMktVcHl4czlFdkxrS1Fz?=
 =?utf-8?B?TXpJc2dTL0c3TUtET2UrOHlCWHlPZWltZ3l1YkdqalVLa2FaVUZjQWtReUdR?=
 =?utf-8?B?ZDFjS1JZWUErL01qLzdWQlU2dDhLSTdzZXJKN2pGVlNmUURRQitNbDdjZzlV?=
 =?utf-8?B?M0cxcDVnTHRiU25aQ0hjQnhmSGlpazZUL0E5WE9wZG1jNzhJbnpIRDhZYUZR?=
 =?utf-8?B?VTVGdmdJSlNZdUpUcnV2VGo2dldPTDYrMHNxdFF6VXZjV0kvY2ppOEFjdUsr?=
 =?utf-8?B?SjVnZGJOd3kxTkNuWEhnSWsyRkR1U25yNEZVMWVZWE8vQzc4UDJNWURVVVRR?=
 =?utf-8?B?NUwwcUJMVVdIRXB4STJEbVJjbHhpTW5tVGV6Z2sxM0pFUXNDRDR6ZzUrSERn?=
 =?utf-8?B?cU9idER6amRYaVM2QjNXcUd4SDE1NXM2b25IQ0lIeGRQdHhVSFc3SldTSFNo?=
 =?utf-8?B?eTJxenlPZVd2NDR3MGhJbktNc2xic1ZuUE9ZbUZvQnJ3QThjR2FERkthYVh5?=
 =?utf-8?B?bDRYNVpFM1JIWDBaVmtMNXgwcFJtNG9LK1Q2NGNoWDdrUU1jcXZlWHhWTTh0?=
 =?utf-8?B?cXJ2cThROXlvYzFEYTZsWHEvUzJYMG12dzY5SzU5VmZqQjcxWXkwM1VaaXl3?=
 =?utf-8?B?NVhiWXpkbnUyMi9yR1pwM3hWZ2JaK0swLzlpN3hIVVZ2MVE5WDhQVitXV1cv?=
 =?utf-8?B?Z2Q3aFpwWVNtSFc1SE4vbUczRC9pV2o1THlNSlUwMWdIeW05TWNVd1BSeTIz?=
 =?utf-8?B?Y1lBZnRsOTlsL0lha0J6QmNRMEVBOGpOQzBMMzVRaDEzcHluZG9CeGIzUjZI?=
 =?utf-8?B?WjdyODBxRnN4ZndvQ3Y2MDEyVlBPak5sLzN4NXdDbW1Hcmo5SjBWUUVacjZB?=
 =?utf-8?B?Rjl5US9NbEhUbnI4YWRraUk3dnpwa08yRzhmWWtRVkx4UXE1clVoNTcyeXQr?=
 =?utf-8?B?NG81YTBoaHJHZElGNHlrRHB3NDVKTjJpVjhmdU1ETVRDRzJGa3YxcVllQm9v?=
 =?utf-8?B?QTFyWFJlL0w3ZlJBOWpYcCtnS0dXcDJTWHkwbW51UHQ4MlZBT0g3WkpWK2lq?=
 =?utf-8?B?R1A3U3paOXNBVnpvWWtYRkVrZXBJOE1wYVBRZmVNNm91ZzI4dy9yV0dMd3dH?=
 =?utf-8?Q?UafS/B/2e2lRNgJtwvLBi7DW2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c7287e-b66c-4e5e-ca66-08dbebe35cec
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 05:16:35.8186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jo1XX9MhPRVGKQs0OWSlZMaH9UBxZ6BB4q+Io3AZXdWcLCSgXjoDDblRvomrtuwsRCExEBDMU5tP6bthiKhKNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/22/2023 9:13 PM, Mario Limonciello wrote:
> On 11/22/2023 00:03, Mika Westerberg wrote:
>> Hi,
>>
>> On Wed, Nov 22, 2023 at 10:36:39AM +0530, Sanath S wrote:
>>> Boot firmware on AMD's Yellow Carp and Pink Sardine allocates
>>> very minimal buses for PCIe downstream ports. This results in
>>> failure to extend the daisy chain.
>>>
>>> Add quirk to reset the downstream port to help reset the topology
>>> created by boot firmware.
>>
>> But this resets the USB4 side of ports, how does this help with the PCIe
>> side? Or this also resets the PCIe side? Please add this information to
>> the changelog too.
>
Sure, I'll add the PCIe side reset in changelog.
> IIUC the PCIe side will be implicitly reset as well.
>
>>
>> I suppose it is not possible to fix the boot firmware?
>
> It's a really difficult case to make with firmware team.  Windows and 
> Linux have a different behavior here.  The Windows CM doesn't take the 
> existing tunnels from firmware and instead always resets them.
> So Windows "isn't affected" by this problem.
>
> Furthermore there are already lots of systems out "in the wild" as 
> these are already both production silicon with shipping OEM products.
>
>>
>>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>>> Signed-off-by: Sanath S <Sanath.S@amd.com>
>>> Fixes: e390909ac763 ("thunderbolt: Add vendor specific NHI quirk for 
>>> auto-clearing interrupt status")
>>> Cc: <stable@vger.kernel.org>
>>> ---
>>> Changes since v1:
>>>   - Initialize ret variable to avoid compiler warning.
>>>   - Add Fixes tag with commit id.
>>> ---
>>>
>>>   drivers/thunderbolt/quirks.c  | 14 ++++++++++++++
>>>   drivers/thunderbolt/switch.c  | 28 ++++++++++++++++++++++++++++
>>>   drivers/thunderbolt/tb.h      |  2 ++
>>>   drivers/thunderbolt/tb_regs.h |  1 +
>>>   4 files changed, 45 insertions(+)
>>>
>>> diff --git a/drivers/thunderbolt/quirks.c 
>>> b/drivers/thunderbolt/quirks.c
>>> index e6bfa63b40ae..45e9d6c43e4a 100644
>>> --- a/drivers/thunderbolt/quirks.c
>>> +++ b/drivers/thunderbolt/quirks.c
>>> @@ -27,6 +27,12 @@ static void quirk_clx_disable(struct tb_switch *sw)
>>>       tb_sw_dbg(sw, "disabling CL states\n");
>>>   }
>>>   +static void quirk_amd_downstream_port_reset(struct tb_switch *sw)
>>> +{
>>> +    sw->quirks |= QUIRK_DPR;
>>> +    tb_sw_dbg(sw, "Resetting Down Stream Port\n");
>>
>> That's "resetting downstream ports\n"
>>
Ack, Will take care in v3.
>>> +}
>>> +
>>>   static void quirk_usb3_maximum_bandwidth(struct tb_switch *sw)
>>>   {
>>>       struct tb_port *port;
>>> @@ -93,6 +99,14 @@ static const struct tb_quirk tb_quirks[] = {
>>>       { 0x0438, 0x0209, 0x0000, 0x0000, quirk_clx_disable },
>>>       { 0x0438, 0x020a, 0x0000, 0x0000, quirk_clx_disable },
>>>       { 0x0438, 0x020b, 0x0000, 0x0000, quirk_clx_disable },
>>> +    /*
>>> +     * Reset Down Stream Ports on AMD USB4 Yellow Carp and
>>> +     * Pink Sardine platforms.
>>> +     */
>>> +    { 0x0438, 0x0208, 0x0000, 0x0000, 
>>> quirk_amd_downstream_port_reset },
>>> +    { 0x0438, 0x0209, 0x0000, 0x0000, 
>>> quirk_amd_downstream_port_reset },
>>> +    { 0x0438, 0x020a, 0x0000, 0x0000, 
>>> quirk_amd_downstream_port_reset },
>>> +    { 0x0438, 0x020b, 0x0000, 0x0000, 
>>> quirk_amd_downstream_port_reset },
>>>   };
>>>     /**
>>> diff --git a/drivers/thunderbolt/switch.c 
>>> b/drivers/thunderbolt/switch.c
>>> index 1e15ffa79295..1c4b1dd5f472 100644
>>> --- a/drivers/thunderbolt/switch.c
>>> +++ b/drivers/thunderbolt/switch.c
>>> @@ -1547,6 +1547,23 @@ static void tb_dump_switch(const struct tb 
>>> *tb, const struct tb_switch *sw)
>>>              regs->__unknown1, regs->__unknown4);
>>>   }
>>>   +static int tb_switch_reset_downstream_port(struct tb_switch *sw)
>>> +{
>>> +    struct tb_port *port;
>>> +    uint32_t val = 0;
>>
>> u32
>>
Ack.
>>> +    int ret = -1;
>>
>> What is -1? Please use proper error codes.
>>
Ack, It'll be ret = -ENODEV;
>>> +
>>> +    tb_switch_for_each_port(sw, port) {
>>> +        if (port->config.type == TB_TYPE_PORT) {
>>
>> You mean
>>
>>     tb_port_is_null()
>>
>> also please make it a separate function, tb_port_reset() following the
>> similar tb_port_unlock() and friends. With the matching kernel-doc and
>> everything.
>>
Sure, I'll handle this and send a v3.
Will also take case of 10ms delay as per spec.
>>> +            val = val | PORT_CS_19_DPR;
>>> +            ret = tb_port_write(port, &val, TB_CFG_PORT,
>>> +                    port->cap_usb4 + PORT_CS_19, 1);
>>
>> Since it is using cap_usb4 you probably need to make usb4_port_reset()
>> as well that gets called from tb_port_reset() (try to make it as simple
>> as possible though).
>>
>>> +            break;
>>
>> It is OK just to reset one port?
>>
As per spec, setting the DPR bit of downstream port would help us 
reconfigure

the USB4 link, So had a condition check only for downstream port.

>>> +        }
>>> +    }
>>> +    return ret;
>>> +}
>>> +
>>>   /**
>>>    * tb_switch_reset() - reconfigure route, enable and send 
>>> TB_CFG_PKG_RESET
>>>    * @sw: Switch to reset
>>> @@ -3201,6 +3218,17 @@ int tb_switch_add(struct tb_switch *sw)
>>>               return ret;
>>>       }
>>>   +    /*
>>> +     * PCIe resource allocated by boot firmware is not utilizing 
>>> all the
>>> +     * available buses, So perform reset of topology to avoid 
>>> failure in
>>> +     * extending daisy chain.
>>> +     */
>>
>> This comment should be inside the quirk, not here.
>>
Sure, I'll remove this comment as it is already mentioned in tb_quirks[]
>>> +    if (sw->quirks & QUIRK_DPR) {
>>> +        ret = tb_switch_reset_downstream_port(sw);
>>
>> And the name of the function should be tb_switch_reset_ports() or so.
>>
Ack.
>>> +        if (ret)
>>> +            return ret;
>>> +    }
>>> +
>>>       ret = tb_switch_port_hotplug_enable(sw);
>>>       if (ret)
>>>           return ret;
>>> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
>>> index e299e53473ae..7a9ff53be67a 100644
>>> --- a/drivers/thunderbolt/tb.h
>>> +++ b/drivers/thunderbolt/tb.h
>>> @@ -23,6 +23,8 @@
>>>   #define QUIRK_FORCE_POWER_LINK_CONTROLLER        BIT(0)
>>>   /* Disable CLx if not supported */
>>>   #define QUIRK_NO_CLX                    BIT(1)
>>> +/* Reset Down Stream Port */
>>> +#define QUIRK_DPR                    BIT(2)
>>>     /**
>>>    * struct tb_nvm - Structure holding NVM information
>>> diff --git a/drivers/thunderbolt/tb_regs.h 
>>> b/drivers/thunderbolt/tb_regs.h
>>> index 87e4795275fe..d49530bc0d53 100644
>>> --- a/drivers/thunderbolt/tb_regs.h
>>> +++ b/drivers/thunderbolt/tb_regs.h
>>> @@ -389,6 +389,7 @@ struct tb_regs_port_header {
>>>   #define PORT_CS_18_CSA                BIT(22)
>>>   #define PORT_CS_18_TIP                BIT(24)
>>>   #define PORT_CS_19                0x13
>>> +#define PORT_CS_19_DPR                BIT(0)
>>>   #define PORT_CS_19_PC                BIT(3)
>>>   #define PORT_CS_19_PID                BIT(4)
>>>   #define PORT_CS_19_WOC                BIT(16)
>>> -- 
>>> 2.34.1
>
