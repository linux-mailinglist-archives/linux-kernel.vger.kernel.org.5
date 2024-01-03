Return-Path: <linux-kernel+bounces-15660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE59822FB7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B321C23700
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEDB1A5B1;
	Wed,  3 Jan 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JM8nqHkI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D1A1A59C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvYqPW7v1ixeljswwIg10wdN2YyeCQtxjhBiWsXue0+sc7Q0gmn5g5swtBT+vAW5dLVy/sGaHjY8PqhoM2c3mZjWxCK50XFC7ok2/I5aFZOh7NtbBR9WmzcXoHxY0tl9PGqzVjjzlMmYFKSbawt/Ol2vYXRE6GDk02ImtaHQFDGU0XBvOlPysFQSswDrkIulojaq1qWfD2ODkSBQWz4AsSVwcfwNkmuZM9O2DeW8juogyx/RYwkVYYN4U4FIDZlc6V14euW0TjwqRaNNq8uz4SS1wQvth4ylvebKqXYj+MQKWfkgqV0Nn/Uut+u0XMDuvNhSjdX6UagoJyErwVMiRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wL1aRJ9t7Io998uTLX/uOr2uhZ+LJqvYFuG4mhm7y/g=;
 b=h6C0Q0+bm1NqO3YSJYNRPRp9TDwmbm4cQNj7n9MEN1tCwwC8kGi3z0iJ5G3sJDHZZIC2bWuEPPFfqyUia2JNMDnNt6Al0h+PMMy9HwR8xojV7MBijr09x/cVoQbCixkpFS/wLYvmLJesaYPtS37VbIEsHkHMdQUeS3xVfXGY6aD/rghpO30Glu/sRYGgHHjqWTnqTUE8CPunFXVU6h9RlfKK6quZgD4gR2lPmPWR5wf+fc4ePpc3s+Bls6ujmDuQI2GFc7J7edZ6/jV1Dwxmsb8wGQW5Ut6KE1ntDCp9WLckC/fMnl8vEU/ijiWrU7UXX6N7dsvFOUeMflBkeA5xig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wL1aRJ9t7Io998uTLX/uOr2uhZ+LJqvYFuG4mhm7y/g=;
 b=JM8nqHkIwp4Lth03AUGfgW7giAU3XJlADQR+4QFxZWbYp4egVZxjbk49d5ItRurWaMg/MES4k0LZBI+ZlRykyGZe5XWobzM4A5TdiVRYCgC7AXPrgbBeZgTnaNbGOBM2DlUmL+prVLh1ThK2KGQEA37ummTPW2xo1LckbdwYHmc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA3PR12MB8021.namprd12.prod.outlook.com (2603:10b6:806:305::16)
 by DM4PR12MB8475.namprd12.prod.outlook.com (2603:10b6:8:190::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 14:40:37 +0000
Received: from SA3PR12MB8021.namprd12.prod.outlook.com
 ([fe80::c7c5:8d05:4f77:e335]) by SA3PR12MB8021.namprd12.prod.outlook.com
 ([fe80::c7c5:8d05:4f77:e335%7]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 14:40:37 +0000
Message-ID: <9362a04a-12b4-4094-9571-cb92efc2979c@amd.com>
Date: Wed, 3 Jan 2024 06:40:34 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mailbox: zynqmp: Enable Bufferless IPI usage on
 Versal-based SOC's
Content-Language: en-US
From: Ben Levinsky <ben.levinsky@amd.com>
To: Michal Simek <michal.simek@amd.com>, jassisinghbrar@gmail.com,
 linux-kernel@vger.kernel.org
Cc: shubhrajyoti.datta@amd.com, tanmay.shah@amd.com,
 linux-arm-kernel@lists.infradead.org
References: <20231214211354.348294-1-ben.levinsky@amd.com>
 <20231214211354.348294-4-ben.levinsky@amd.com>
 <ea76da63-4758-400f-a5ed-9cb223b65c80@amd.com>
 <038659b4-a148-4663-870e-898f33406a08@amd.com>
In-Reply-To: <038659b4-a148-4663-870e-898f33406a08@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:74::17) To SA3PR12MB8021.namprd12.prod.outlook.com
 (2603:10b6:806:305::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB8021:EE_|DM4PR12MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: 54075d39-612d-4491-79d9-08dc0c69f369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fwwq8RQ6uAwZYti6XT3Wo8mqX1yNk6m3NJUyZt7SMjq5dpkKIh1yZhaQg/pMndayXmjgdS0+T5v2ZaKckWBkNnHa8K021Qyo3JTSEL3YIbmxqCUX0tYG7jGaFjuzJx+ZLazYARGfnhUJO75Jc6MxyHbMauNSLmgJX9VDF1Xj2lsF/uzD3OEFHEoNXGo6hoJK1P8E+0WGAznpNsTe9FPPD+scfvQxJLWdT52vN7/jtZcCkIuMVrTVaBEokB/JLVXfgQ97M+FV8SdOMegUF4DleGTFaBvPJYy+iRz/BUMrlXE3JtlUvurHmDiH1fRw8UtaCd/cAUrJTfopbaoAaWdZUMe8MLdFDjhu8/P6lvlaYDhE5DxlAOA85fNSNKNexRRDgxwA2cbMMPx2LIL6w7nep0FqLR0gkIE2vgjaixknvtR18mNXTRxqWgVMEkx06CE9TNk5LKP0YGmKilHHl65MTA6h8JQBsEZ2AUQAh6Y/VvVcGwBmPcJW806oVEzGU7C5gs77iiS9aEL0QlZC1Tp3DOoQbiLEYOlx5peKQxmdJdQq5sJReIePSH6N23AWVz7r3itMd+qSaFJp7mfx2/wawPVWcCSWArQIrfp/W7XEPUPkkjZmtXcyDhrikOKIQ1dEajrAKUuQOSGNq7iWTagUWw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB8021.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(346002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(26005)(83380400001)(6512007)(8676002)(2616005)(53546011)(8936002)(44832011)(41300700001)(4326008)(15650500001)(2906002)(478600001)(66476007)(966005)(6666004)(66946007)(6506007)(6486002)(5660300002)(66556008)(316002)(86362001)(36756003)(31696002)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmlDZWZnWEhjT1B5bmFtRWY4akhHKzcvVmZ0eXMwU2kyb3AzejYrbmVlZUNC?=
 =?utf-8?B?aWl2SVVlN2hJMVpJUXhyd0d3b2ZRdWk4czRxU21rbXBQRWU0a2JRc1QrM2RX?=
 =?utf-8?B?TTNnL1RGVk15UHVic0dDS0ErMjZDY2JIc3YwOWhhT1ErT08wOE1MTXRVdE41?=
 =?utf-8?B?NVd6cmpJeU5NeDVFcXBSQWNRckZLVndRdVdjM2Z2NDUrQm5BMjI3cW93eFQx?=
 =?utf-8?B?d2NKbW9ndTVCRmphNW1JdlJPMldRYzdObncrbVlXT1RnVmRFNlluTVlpV1Zo?=
 =?utf-8?B?VmFEaDJ0aklra1lUQXQ4RXRsallUU2s0YUczNTJpUE9sSFNRdUpZNGJ1N0JV?=
 =?utf-8?B?VGZaVExUM3hWbWppZHVMdk9OUW1FTU4wVHdjQU1BdkRjcUJzUlZjVnh2S0RY?=
 =?utf-8?B?ZFJ5TDhkMFNRVjkxc2RRRXhmZWdqL3dMSVdieUxvNU1vNzF0am85VjMxMDhp?=
 =?utf-8?B?UHJ6WkxZY21CRE14ZDFXUWpoTGxyTzdIZ1k1MGovQlFia2NmbUlSUnh2SzI1?=
 =?utf-8?B?M0pyNjZjMnkwaEh0R1hGMTVjNmdoRGhJY0VzQ0pFTm5OWU1COE9YMlF0OWkw?=
 =?utf-8?B?eDNpSUdjcERiZWhzWmlUL1NWMGcrRU5aWWVBK1gwZTJBaWtPU01TRnFrN3Fs?=
 =?utf-8?B?b05lbjFKbUZxREpmWGFxUmJXZDlNSVpNWW9hcnZ6WFNNbHQwSjBzMmRONVNn?=
 =?utf-8?B?a3ptbEx4Y3hkWlpkKzdqL0IxY1pxUVJFaXU4OVNJVFF5VTk2M2U5NC9BVnFT?=
 =?utf-8?B?UXBFbkZxdTNiVElpRzZHMmpxNStQSGlEZnRPcVdyMHp4NERCbWJDd0ZIVGgy?=
 =?utf-8?B?OG5Kem93SXI1TXR0WVRkVEt3ZzFhY1dCZ1J2bFRpcHV2M3NhcEx0NEExbGRq?=
 =?utf-8?B?SCtFRlMzZmhxNVRaUUpoMHN5UE9DdExnZkRwSWgrazZ2ZUhSVnZUa3d6djdU?=
 =?utf-8?B?OEg1WDA3M0dWcCtvdmphcjF2dlJLU1BSdUdjaVhjUXY2TjR0cVNLQUVTWXcr?=
 =?utf-8?B?Ynh0MWNsL3M3QlBST25kVkoyR3N4MUpKTW9BdjJLeTZib0VkbWtPSXBGZXpH?=
 =?utf-8?B?Qm9FaWgyZEJ5Q3JucTRuWWlLbDRRa21jL1VOQWRSUFl0b0xKQlhOUmNkRzFl?=
 =?utf-8?B?QVBzWTk2WmNGU2E1WTRKMEFPeVBha3Yxa3dseHBnZGpzQ1BMQW8wTnBCcGlY?=
 =?utf-8?B?K3Q0dk4vZFY5bnBTd3ZQSjNkNUhvYWJ2dDZLUnNXdE5mbEJjTy9OMXJLVXdv?=
 =?utf-8?B?cVpNTFNtejV0bXRxQTFZUG5LMTJDem1KTC90Ly9IOExzelJMd25vWUt6NXVz?=
 =?utf-8?B?Q2V3Tk9rZzRvT1Y0aGFjQXByNTlXZFpxR1NaSzh1NVllaEhzbjVCeWV4K0ts?=
 =?utf-8?B?aUg5WWd3V2JURHhvSThEZnRZUlQrMi9CZCtIRGdMSUg4bDVUYTNWS2NkRE1V?=
 =?utf-8?B?cGYyZGsxU1N4Um5aYWs4aS90dFBWdU54Uy9hZ0ZvaGNYRnZuUUJGMlJHb2Nh?=
 =?utf-8?B?REM4M1kwVDRHN2FjWHFrK0oxNnhtemxaYmJGV0lPUk9wcXMzNTE5UFdKY0pS?=
 =?utf-8?B?RDgvcmYwZW4yRkxlYmNPNGhHMk1rUjlyeG9hTWp4YStMVFFMWUxEdGpKZzRV?=
 =?utf-8?B?TVh1U25SVEdHRlBTNElOSEV1b1Vkb2d3NkQ4bTRsRVRHd1NZcVBIV1RacWVI?=
 =?utf-8?B?MTd4cFFBTDVxVVZmdmVjeHlNVndTWUtrSG5PUTVDcGpyUkhrcytSNUFNV2VL?=
 =?utf-8?B?MC9PeGZ6R2lyY1RlSXRGbi9FSEJpT0RlUHVMN3VaYTdjaEFZTGNnQzY0aUtT?=
 =?utf-8?B?WStPVEovWnVDMUFJMUFEczhjUmpBQTY3ZDNySnFsanhUNnZ4MEtOTlRiRXR0?=
 =?utf-8?B?aVZLdkY5YkN4dlY4OE5XNnNTRnZzVVhHVndXTXFjc1ZYOUdJeU96Q3cxYldI?=
 =?utf-8?B?SU9zdnlRV1dDNUVTWUFHU0xJRHRBQzdza3JoYi94NUpKUVAwR2Nvdis3V0Uw?=
 =?utf-8?B?TDNVL1ZBZ05yMThkd0tvbDhCUnBxNTh0V2E5SzdXV3Y1WEhST1dxNTZTNTB3?=
 =?utf-8?B?Smx1c3hyTU5XRGlJTFlnZ21nYmNNNVZRbTdpNTJyTTZsWm1zYm5vN1BiSW5O?=
 =?utf-8?Q?cjzWVFOllMZLF1JuInDog0Xu/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54075d39-612d-4491-79d9-08dc0c69f369
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB8021.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 14:40:37.6461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47C4mUzxsBi1r+/tyVMJQIy324kD942R8vFjAERJSLNK5mNoGfG+zEoqvrFHP48h7vfn7go/CyO3fTI4bbOahw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8475

Hi Jassi,


Please review when you can.


Thanks and Kind Regards,

Ben

On 12/20/23 9:42 AM, Ben Levinsky wrote:
> On 12/20/23 5:29 AM, Michal Simek wrote:
>>
>> On 12/14/23 22:13, Ben Levinsky wrote:
>>> On Xilinx-AMD Versal and Versal-NET, there exist both
>>> inter-processor-interrupts with corresponding message buffers and without
>>> such buffers.
>>>
>>> Add a routine that, if the corresponding DT compatible
>>> string "xlnx,versal-ipi-mailbox" is used then a Versal-based SOC
>>> can use a mailbox Device Tree entry where both host and remote
>>> can use either of the buffered or bufferless interrupts.
>>>
>>> Signed-off-by: Ben Levinsky <ben.levinsky@amd.com>
>>> ---
>>> Note that the linked patch provides corresponding bindings.
>>> Depends on: https://lore.kernel.org/all/20231214054224.957336-3-tanmay.shah@amd.com/T/
>>> ---
>>>   drivers/mailbox/zynqmp-ipi-mailbox.c | 146 +++++++++++++++++++++++++--
>>>   1 file changed, 139 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
>>> index edefb80a6e47..316d9406064e 100644
>>> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
>>> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
>>> @@ -52,6 +52,13 @@
>>>   #define IPI_MB_CHNL_TX    0 /* IPI mailbox TX channel */
>>>   #define IPI_MB_CHNL_RX    1 /* IPI mailbox RX channel */
>>>   +/* IPI Message Buffer Information */
>>> +#define RESP_OFFSET    0x20U
>>> +#define DEST_OFFSET    0x40U
>>> +#define IPI_BUF_SIZE    0x20U
>>> +#define DST_BIT_POS    9U
>>> +#define SRC_BITMASK    GENMASK(11, 8)
>>> +
>>>   /**
>>>    * struct zynqmp_ipi_mchan - Description of a Xilinx ZynqMP IPI mailbox channel
>>>    * @is_opened: indicate if the IPI channel is opened
>>> @@ -170,9 +177,11 @@ static irqreturn_t zynqmp_ipi_interrupt(int irq, void *data)
>>>           if (ret > 0 && ret & IPI_MB_STATUS_RECV_PENDING) {
>>>               if (mchan->is_opened) {
>>>                   msg = mchan->rx_buf;
>>> -                msg->len = mchan->req_buf_size;
>>> -                memcpy_fromio(msg->data, mchan->req_buf,
>>> -                          msg->len);
>>> +                if (msg) {
>>> +                    msg->len = mchan->req_buf_size;
>>> +                    memcpy_fromio(msg->data, mchan->req_buf,
>>> +                              msg->len);
>>> +                }
>>>                   mbox_chan_received_data(chan, (void *)msg);
>>>                   status = IRQ_HANDLED;
>>>               }
>>> @@ -282,26 +291,26 @@ static int zynqmp_ipi_send_data(struct mbox_chan *chan, void *data)
>>>         if (mchan->chan_type == IPI_MB_CHNL_TX) {
>>>           /* Send request message */
>>> -        if (msg && msg->len > mchan->req_buf_size) {
>>> +        if (msg && msg->len > mchan->req_buf_size && mchan->req_buf) {
>>>               dev_err(dev, "channel %d message length %u > max %lu\n",
>>>                   mchan->chan_type, (unsigned int)msg->len,
>>>                   mchan->req_buf_size);
>>>               return -EINVAL;
>>>           }
>>> -        if (msg && msg->len)
>>> +        if (msg && msg->len && mchan->req_buf)
>>>               memcpy_toio(mchan->req_buf, msg->data, msg->len);
>>>           /* Kick IPI mailbox to send message */
>>>           arg0 = SMC_IPI_MAILBOX_NOTIFY;
>>>           zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, &res);
>>>       } else {
>>>           /* Send response message */
>>> -        if (msg && msg->len > mchan->resp_buf_size) {
>>> +        if (msg && msg->len > mchan->resp_buf_size && mchan->resp_buf) {
>>>               dev_err(dev, "channel %d message length %u > max %lu\n",
>>>                   mchan->chan_type, (unsigned int)msg->len,
>>>                   mchan->resp_buf_size);
>>>               return -EINVAL;
>>>           }
>>> -        if (msg && msg->len)
>>> +        if (msg && msg->len && mchan->resp_buf)
>>>               memcpy_toio(mchan->resp_buf, msg->data, msg->len);
>>>           arg0 = SMC_IPI_MAILBOX_ACK;
>>>           zynqmp_ipi_fw_call(ipi_mbox, arg0, IPI_SMC_ACK_EIRQ_MASK,
>>> @@ -640,6 +649,126 @@ static int zynqmp_ipi_setup(struct zynqmp_ipi_mbox *ipi_mbox,
>>>       return 0;
>>>   }
>>>   +/**
>>> + * versal_ipi_setup - Set up IPIs to support mixed usage of
>>> + *                 Buffered and Bufferless IPIs.
>>> + *
>>> + * @ipi_mbox: pointer to IPI mailbox private data structure
>>> + * @node: IPI mailbox device node
>>> + *
>>> + * Return: 0 for success, negative value for failure
>>> + */
>>> +static int versal_ipi_setup(struct zynqmp_ipi_mbox *ipi_mbox,
>>> +                struct device_node *node)
>>> +{
>>> +    struct zynqmp_ipi_mchan *tx_mchan, *rx_mchan;
>>> +    struct resource host_res, remote_res;
>>> +    struct device_node *parent_node;
>>> +    int host_idx, remote_idx;
>>> +    struct device *mdev, *dev;
>>> +
>>> +    tx_mchan = &ipi_mbox->mchans[IPI_MB_CHNL_TX];
>>> +    rx_mchan = &ipi_mbox->mchans[IPI_MB_CHNL_RX];
>>> +    parent_node = of_get_parent(node);
>>> +    dev = ipi_mbox->pdata->dev;
>>> +    mdev = &ipi_mbox->dev;
>>> +
>>> +    host_idx = zynqmp_ipi_mbox_get_buf_res(parent_node, "msg", &host_res);
>>> +    remote_idx = zynqmp_ipi_mbox_get_buf_res(node, "msg", &remote_res);
>>> +
>>> +    /*
>>> +     * Only set up buffers if both sides claim to have msg buffers.
>>> +     * This is because each buffered IPI's corresponding msg buffers
>>> +     * are reserved for use by other buffered IPI's.
>>> +     */
>>> +    if (!host_idx && !remote_idx) {
>>> +        u32 host_src, host_dst, remote_src, remote_dst;
>>> +        u32 buff_sz;
>>> +
>>> +        buff_sz = resource_size(&host_res);
>>> +
>>> +        host_src = host_res.start & SRC_BITMASK;
>>> +        remote_src = remote_res.start & SRC_BITMASK;
>>> +
>>> +        host_dst = (host_src >> DST_BIT_POS) * DEST_OFFSET;
>>> +        remote_dst = (remote_src >> DST_BIT_POS) * DEST_OFFSET;
>>> +
>>> +        /* Validate that IPI IDs is within IPI Message buffer space. */
>>> +        if (host_dst >= buff_sz || remote_dst >= buff_sz) {
>>> +            dev_err(mdev,
>>> +                "Invalid IPI Message buffer values: %x %x\n",
>>> +                host_dst, remote_dst);
>>> +            return -EINVAL;
>>> +        }
>>> +
>>> +        tx_mchan->req_buf = devm_ioremap(mdev,
>>> +                         host_res.start | remote_dst,
>>> +                         IPI_BUF_SIZE);
>>> +        if (!tx_mchan->req_buf) {
>>> +            dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
>>> +            return -ENOMEM;
>>> +        }
>>> +
>>> +        tx_mchan->resp_buf = devm_ioremap(mdev,
>>> +                          (remote_res.start | host_dst) +
>>> +                          RESP_OFFSET, IPI_BUF_SIZE);
>>> +        if (!tx_mchan->resp_buf) {
>>> +            dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
>>> +            return -ENOMEM;
>>> +        }
>>> +
>>> +        rx_mchan->req_buf = devm_ioremap(mdev,
>>> +                         remote_res.start | host_dst,
>>> +                         IPI_BUF_SIZE);
>>> +        if (!rx_mchan->req_buf) {
>>> +            dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
>>> +            return -ENOMEM;
>>> +        }
>>> +
>>> +        rx_mchan->resp_buf = devm_ioremap(mdev,
>>> +                          (host_res.start | remote_dst) +
>>> +                          RESP_OFFSET, IPI_BUF_SIZE);
>>> +        if (!rx_mchan->resp_buf) {
>>> +            dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
>>> +            return -ENOMEM;
>>> +        }
>>> +
>>> +        tx_mchan->resp_buf_size = IPI_BUF_SIZE;
>>> +        tx_mchan->req_buf_size = IPI_BUF_SIZE;
>>> +        tx_mchan->rx_buf = devm_kzalloc(mdev, IPI_BUF_SIZE +
>>> +                        sizeof(struct zynqmp_ipi_message),
>>> +                        GFP_KERNEL);
>>> +        if (!tx_mchan->rx_buf)
>>> +            return -ENOMEM;
>>> +
>>> +        rx_mchan->resp_buf_size = IPI_BUF_SIZE;
>>> +        rx_mchan->req_buf_size = IPI_BUF_SIZE;
>>> +        rx_mchan->rx_buf = devm_kzalloc(mdev, IPI_BUF_SIZE +
>>> +                        sizeof(struct zynqmp_ipi_message),
>>> +                        GFP_KERNEL);
>>> +        if (!rx_mchan->rx_buf)
>>> +            return -ENOMEM;
>>> +    } else {
>>> +        /*
>>> +         * If here, then set up Bufferless IPI Channel because
>>> +         * one or both of the IPI's is bufferless.
>>> +         */
>>> +        tx_mchan->req_buf = NULL;
>>> +        tx_mchan->resp_buf = NULL;
>>> +        tx_mchan->rx_buf = NULL;
>>> +        tx_mchan->resp_buf_size = 0;
>>> +        tx_mchan->req_buf_size = 0;
>>> +
>>> +        rx_mchan->req_buf = NULL;
>>> +        rx_mchan->resp_buf = NULL;
>>> +        rx_mchan->rx_buf = NULL;
>>> +        rx_mchan->resp_buf_size = 0;
>>> +        rx_mchan->req_buf_size = 0;
>> Just curious if this is really needed. If none fills that values aren't they actually already 0/NULL because that location is cleared by kzalloc.
>>
>> Thanks,
>> Michal
> Confirmed. I removed the whole else condition and it still worked.
>
> Will update in next rev after I receive any pending feedback from Jassi
>

