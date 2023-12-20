Return-Path: <linux-kernel+bounces-7360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5AE81A686
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851381F22DEF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81409482CB;
	Wed, 20 Dec 2023 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aEePvxQi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC69482C5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YASvMZBNqEkB2+WfPjzwEBvlOIR/rLQbW+gp66Kyk5pigI8gXPK6WyRHNuzBK5tZ/LdxOn95/NCJmlWS52UCz/BW+oV80ykJijmlfj0CC/nw6+ZDBxvxfbj5L8K8mZUk8z9pRUXto0EXxF3omBRKO+FRjAkbM4Lo+TO+OjqYlKbV2EskOE5G84LJfhAv7lv7QZz2D++tBnow/LYVGiLzX36+mz4TXPAXA32xSX17OWh9cYXiNleSxMGhgNyEW2e9DhIjIevGmvTg3yaWVrLaIqVFNQZTfNlzoD2T/mOJLjslwruvPMVFOcxYQgA95g5ClEV7DnQi4hcd6ugziorYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V44UxWIVK3nsCEgkfVfAMXEWqZ3Jj2RYchIlA0u/Yy0=;
 b=iN43Eg95E8XH3sqDe7HBIGGDrSaM7/YAf9sIH+ihrM1xmDRHqIoJzzwYK2n8vTj1ShEuqdOm0wEya3Tgr55Ug8w31/HT5ZX/4xPWm8qOAfQxTG6o1ZUk84qxJQa9Ej25D8JSXpqRwtQPMwmNPkRQ+gOgb+HI5VC6XJXmuzi/bdljn5abNsUHbnGb895whHSJKgJ7k9nHqyzpIpnqDN5OoRa6qNo22Gqd/WdTFv1h8UlRkpJ2ADHykIuz1CGwMEMcuwkcjoi49zBh10Ty0I/iJbQoPFUM9vHIF89Z9pB6VX0jfVDKZk7bLekk+h9g3dhodSc1c3yFQinp0UA/IeMf7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V44UxWIVK3nsCEgkfVfAMXEWqZ3Jj2RYchIlA0u/Yy0=;
 b=aEePvxQix2lO/FUdvklFjEmpS2hdL6pQUokMqxZVz37InTVDCapCoL9BPFPNpJDRrxCzAlelupC+yKqsUjL5UQ3jeqLG3mF9nZPbyy8Aq8ABaFwM/58qC4ueSFGFJIAJAXzy4kumR64V5cGkxNV3uaYKEUrwqPz2JXrDNBftlX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA3PR12MB8021.namprd12.prod.outlook.com (2603:10b6:806:305::16)
 by PH7PR12MB7889.namprd12.prod.outlook.com (2603:10b6:510:27f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 17:42:47 +0000
Received: from SA3PR12MB8021.namprd12.prod.outlook.com
 ([fe80::c7c5:8d05:4f77:e335]) by SA3PR12MB8021.namprd12.prod.outlook.com
 ([fe80::c7c5:8d05:4f77:e335%7]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 17:42:47 +0000
Message-ID: <038659b4-a148-4663-870e-898f33406a08@amd.com>
Date: Wed, 20 Dec 2023 09:42:44 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mailbox: zynqmp: Enable Bufferless IPI usage on
 Versal-based SOC's
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, jassisinghbrar@gmail.com,
 linux-kernel@vger.kernel.org
Cc: shubhrajyoti.datta@amd.com, tanmay.shah@amd.com,
 linux-arm-kernel@lists.infradead.org
References: <20231214211354.348294-1-ben.levinsky@amd.com>
 <20231214211354.348294-4-ben.levinsky@amd.com>
 <ea76da63-4758-400f-a5ed-9cb223b65c80@amd.com>
From: Ben Levinsky <ben.levinsky@amd.com>
In-Reply-To: <ea76da63-4758-400f-a5ed-9cb223b65c80@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0021.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::34) To SA3PR12MB8021.namprd12.prod.outlook.com
 (2603:10b6:806:305::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB8021:EE_|PH7PR12MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4aae2e-fda7-4d18-9cfa-08dc01831445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wu86g4S7pe86zfKFVqEtd2UIhsSVjErSqNY/O/9keKNsZK2L2AUuFttfXQluj+Fewhj6X+amg7Z6DkrHURwoogHpu9Td8SYkyoUWoBZrQPNGy2nqr847sM4QcFro5+mdfYK7uRqKx3uBGFKm2LcqZGslgZ1X085MSPM7kEUbMZymYDUzfyltl/Bgakl3gqcJa5yHux4a4uFtE8oMJ8zFme/NQkIi6IGKWblDhFnIKxM5u74TMzZ7CPFPz4hSWXR7VVes0jp6LxttN4jHEq0g+8c1Ir5SWdk0bgLBlVG30l6xAbG4d1YE6pE+miT0crlUWgkTPA88jZY3dqrriGriQx0o/U/MQWGmvL7JurkKzsDIf92+p5TLcxV/BcnF7tfwN8JzeRuPU5BO1JyiL9GkVlhNggc0wE8izDWUWM9G2G+2C/r76vNWDW6lCbI7S2542fglki7G8SbQ4Y9eCs9Gu/p7m12piK+hRIibh36FPk6lgIuUTUugax7yvm6BAzAzVVNB4M9uaK8k09Z5RYP5Cp1V9a6y25b0nMRCsvE9TU03PSJsHFYAABaEzFlF+QH/wVsfiEuML3ozU/4mfqWrhGJOaJfs5kFeUxsTuRKxM+k9J+WGLlAAFKegMXDDUHK6ACX1HzldJxu34dTAva3K7A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB8021.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2616005)(6512007)(31686004)(83380400001)(36756003)(86362001)(38100700002)(31696002)(6506007)(26005)(53546011)(478600001)(966005)(6666004)(6486002)(4326008)(8936002)(316002)(5660300002)(44832011)(15650500001)(8676002)(2906002)(41300700001)(66556008)(66476007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T21VdkdEYkVyYXlnZ0piK0Y3c0VRMm4zMEZSUFRWRWo0OTkzSEplU2gxeDJv?=
 =?utf-8?B?bkRoVnBRMm1Va0kyYWNSbjkvaHpIeERXY1lYS05Mc2VBaVhTZElnUGRIbHZO?=
 =?utf-8?B?dk5EV0hDREFPZ2gvSi9rSGN4cFNpTm9od2hxR0F0MXQ1cHEza3ZJS0VMU21i?=
 =?utf-8?B?bEs1bW9qQ0RRZnV4a21oNFkyRlhickhLdTFZbDN0dVVRODFEcWU3ZGlaS05X?=
 =?utf-8?B?RVpXVDA5THhQWHQ4dm1DOEFaMUJwT0MwTTJnRTFRMXAwcExRVDY5Q2hMazQ5?=
 =?utf-8?B?b3FYdit3UnFlRlMzZU0yeE9FR25RaGZ6UDlma21DZnZqSnZOUlJCN255YWdK?=
 =?utf-8?B?QTRtVkdRenpPdnAxd0tSNFhDeUNuVzl0ek1TcGkwM1NMWERJMlVCR1pmUFFj?=
 =?utf-8?B?Zmt1eStxaVhhQnJJQzJqamlRbFhqa3RpWjNVNkxDVTdPMnNYSnZObEJFeTB0?=
 =?utf-8?B?VnhmQW55WGtvQ3NEVE9aVjdVczZkSGNJNEFWS0tHRWFnWVNia1BYOEhVSTZi?=
 =?utf-8?B?Q1ErL2RuQ1dud1drVjYzQXFNcTlpOU9mYzVnSSsrUHZ2dW9IUm02VFkrWi94?=
 =?utf-8?B?dEN6d2hDWHFpaW5la1IrYnYxb3hVbWN2dWlxR0l0eG9IenBEWlM5OUtCcmEx?=
 =?utf-8?B?RlpPNFBYcDhyaFVPTHNMWUVHbHAzWnFMbmZOWnZyL1BRVkFvN0Z0N25zNXpo?=
 =?utf-8?B?YndVZGFpdE16dDI5SjI5Vm5CdU8zSHY4N2wwRkZtVlBQaEY2dkMvTUQ0UzFR?=
 =?utf-8?B?eGtEeVZ5V0w4c0FJUW52U1FIN1lRaFZSaGhic3NOdnUxaEE5SnNFbG9yVnNw?=
 =?utf-8?B?OURIOGNubEJIbWxmMjk5V1JTTFhlZGd2SUFla1JrNHZFNnFiZklCbzkyRkl4?=
 =?utf-8?B?bElob1BOUXNMOUViK1NhYlVWazlXYjBVbnN1VFZJdmtvM1BXVGVXVmduNTIy?=
 =?utf-8?B?ZDBNQWl0RUpUQW9VblhnMERjdlBmbUdBVmVNbStJdXhhL3daNXFaTm9vTHdJ?=
 =?utf-8?B?Yi9EWVRzcDFhNmNSYnpWcVdpenNmekF0T2IyeEVzUU9WSWF3dEEzbzBMTitk?=
 =?utf-8?B?cHVzdGVFRVp4SzRHbEZEbjdBMmY0MFVyZk5rV2VtOTFaTnhHUlFMY05hN0hq?=
 =?utf-8?B?MERiQUt0cDhYRlBTZlptUEZDdTVmZVpDOCsrMkNxdEhNbkpmNENTay84Z3lK?=
 =?utf-8?B?dVQvZ3hhRnRvVmZqNzRwb1JYbWEwMGtsTkRPajdKays1M0Rxd2tGSHlsVHpi?=
 =?utf-8?B?RmM0bDhlSmxRZ3k1Zmpxd0lwbm9rR3k2Z3MxelYxaUw3ckZqRnF5N0xoS2sx?=
 =?utf-8?B?SlV4THp1T3l2dWFydERBcXA3OTZ0eFBRTUZkNGo3YUMzY3JxUWRrMFNwcTR4?=
 =?utf-8?B?UTlhVkQ1bzdBamUyL0JYTzh1dUdXai82UDE5U3RPMWxmczBKS0dNMjE4Vjl4?=
 =?utf-8?B?eTNtRmJnYzNTcGZiMlpaWUptNkFpSWFzNThoanhocHpRbmczOTU3NUUzZzB3?=
 =?utf-8?B?Uzc4N1lqTnk4NUNFdVNEQVVmNFpFYjlXL1djN0kyRTU1YVZ6ZlNpS2E3akpr?=
 =?utf-8?B?L0ExY2RiQ0N5ditlNWpHcWx4b1kvam5hek8yMkF3bzNvc1lBR2lBcjNwRXNW?=
 =?utf-8?B?eU5JN0txVUZJdUFvcERBZkgzMlZWMnVPaFZrRnhySFNYNzdUSkY5SlRQT09j?=
 =?utf-8?B?eGxnTDFlWjAzMHoyRFpIa0ZJaW5pb2g1NzhyTEdFN0NIRy84TEo0L3VZeEhW?=
 =?utf-8?B?RXp1VHYrMllMS3JzUzRtUGwyRlJyMWp2ZGw3bFRqK3BxZTRhM0hyUTM4Y0xU?=
 =?utf-8?B?WEFzc2d4b1dpWTRpWTB4cGdxSGNCalpHMjJNYmd0OVdRYWZTWlF5ekhZZDVz?=
 =?utf-8?B?VTRLTU80NFBsaXFjcVJ6bnJ5aW9BeFFDdFNWclorVmxiV2J5dzZ0UlZtRnZo?=
 =?utf-8?B?b1J2bGU2OVJuMHNqUGdkMmNza3F1ck02d1VYN3lFQ1JUVDNNTUI0QjE2V01B?=
 =?utf-8?B?TjBmUjZhd3dYRmQyZ3RaYVQzcDdqand1TnhZbklCRDczTzAzMkJPL3Rub1pE?=
 =?utf-8?B?R0lFOURkZnVNYnl1TjJyMHl4QlUxUW5rWFVGNjhNdFgwUjhTaEZLWUkwTC9m?=
 =?utf-8?Q?ScBZX8Z+TF/s7zgQF5TpcfiPF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4aae2e-fda7-4d18-9cfa-08dc01831445
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB8021.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 17:42:47.3726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnaxoVSXLxZXesxfUjesMgoDeyfPRRTwoN8rz8gSPijqzdcdnv4NhuCvrqnpNKc7b/6Z+jeC4fnW0T5Aij+kgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7889


On 12/20/23 5:29 AM, Michal Simek wrote:
>
>
> On 12/14/23 22:13, Ben Levinsky wrote:
>> On Xilinx-AMD Versal and Versal-NET, there exist both
>> inter-processor-interrupts with corresponding message buffers and without
>> such buffers.
>>
>> Add a routine that, if the corresponding DT compatible
>> string "xlnx,versal-ipi-mailbox" is used then a Versal-based SOC
>> can use a mailbox Device Tree entry where both host and remote
>> can use either of the buffered or bufferless interrupts.
>>
>> Signed-off-by: Ben Levinsky <ben.levinsky@amd.com>
>> ---
>> Note that the linked patch provides corresponding bindings.
>> Depends on: https://lore.kernel.org/all/20231214054224.957336-3-tanmay.shah@amd.com/T/
>> ---
>>   drivers/mailbox/zynqmp-ipi-mailbox.c | 146 +++++++++++++++++++++++++--
>>   1 file changed, 139 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
>> index edefb80a6e47..316d9406064e 100644
>> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
>> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
>> @@ -52,6 +52,13 @@
>>   #define IPI_MB_CHNL_TX    0 /* IPI mailbox TX channel */
>>   #define IPI_MB_CHNL_RX    1 /* IPI mailbox RX channel */
>>   +/* IPI Message Buffer Information */
>> +#define RESP_OFFSET    0x20U
>> +#define DEST_OFFSET    0x40U
>> +#define IPI_BUF_SIZE    0x20U
>> +#define DST_BIT_POS    9U
>> +#define SRC_BITMASK    GENMASK(11, 8)
>> +
>>   /**
>>    * struct zynqmp_ipi_mchan - Description of a Xilinx ZynqMP IPI mailbox channel
>>    * @is_opened: indicate if the IPI channel is opened
>> @@ -170,9 +177,11 @@ static irqreturn_t zynqmp_ipi_interrupt(int irq, void *data)
>>           if (ret > 0 && ret & IPI_MB_STATUS_RECV_PENDING) {
>>               if (mchan->is_opened) {
>>                   msg = mchan->rx_buf;
>> -                msg->len = mchan->req_buf_size;
>> -                memcpy_fromio(msg->data, mchan->req_buf,
>> -                          msg->len);
>> +                if (msg) {
>> +                    msg->len = mchan->req_buf_size;
>> +                    memcpy_fromio(msg->data, mchan->req_buf,
>> +                              msg->len);
>> +                }
>>                   mbox_chan_received_data(chan, (void *)msg);
>>                   status = IRQ_HANDLED;
>>               }
>> @@ -282,26 +291,26 @@ static int zynqmp_ipi_send_data(struct mbox_chan *chan, void *data)
>>         if (mchan->chan_type == IPI_MB_CHNL_TX) {
>>           /* Send request message */
>> -        if (msg && msg->len > mchan->req_buf_size) {
>> +        if (msg && msg->len > mchan->req_buf_size && mchan->req_buf) {
>>               dev_err(dev, "channel %d message length %u > max %lu\n",
>>                   mchan->chan_type, (unsigned int)msg->len,
>>                   mchan->req_buf_size);
>>               return -EINVAL;
>>           }
>> -        if (msg && msg->len)
>> +        if (msg && msg->len && mchan->req_buf)
>>               memcpy_toio(mchan->req_buf, msg->data, msg->len);
>>           /* Kick IPI mailbox to send message */
>>           arg0 = SMC_IPI_MAILBOX_NOTIFY;
>>           zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, &res);
>>       } else {
>>           /* Send response message */
>> -        if (msg && msg->len > mchan->resp_buf_size) {
>> +        if (msg && msg->len > mchan->resp_buf_size && mchan->resp_buf) {
>>               dev_err(dev, "channel %d message length %u > max %lu\n",
>>                   mchan->chan_type, (unsigned int)msg->len,
>>                   mchan->resp_buf_size);
>>               return -EINVAL;
>>           }
>> -        if (msg && msg->len)
>> +        if (msg && msg->len && mchan->resp_buf)
>>               memcpy_toio(mchan->resp_buf, msg->data, msg->len);
>>           arg0 = SMC_IPI_MAILBOX_ACK;
>>           zynqmp_ipi_fw_call(ipi_mbox, arg0, IPI_SMC_ACK_EIRQ_MASK,
>> @@ -640,6 +649,126 @@ static int zynqmp_ipi_setup(struct zynqmp_ipi_mbox *ipi_mbox,
>>       return 0;
>>   }
>>   +/**
>> + * versal_ipi_setup - Set up IPIs to support mixed usage of
>> + *                 Buffered and Bufferless IPIs.
>> + *
>> + * @ipi_mbox: pointer to IPI mailbox private data structure
>> + * @node: IPI mailbox device node
>> + *
>> + * Return: 0 for success, negative value for failure
>> + */
>> +static int versal_ipi_setup(struct zynqmp_ipi_mbox *ipi_mbox,
>> +                struct device_node *node)
>> +{
>> +    struct zynqmp_ipi_mchan *tx_mchan, *rx_mchan;
>> +    struct resource host_res, remote_res;
>> +    struct device_node *parent_node;
>> +    int host_idx, remote_idx;
>> +    struct device *mdev, *dev;
>> +
>> +    tx_mchan = &ipi_mbox->mchans[IPI_MB_CHNL_TX];
>> +    rx_mchan = &ipi_mbox->mchans[IPI_MB_CHNL_RX];
>> +    parent_node = of_get_parent(node);
>> +    dev = ipi_mbox->pdata->dev;
>> +    mdev = &ipi_mbox->dev;
>> +
>> +    host_idx = zynqmp_ipi_mbox_get_buf_res(parent_node, "msg", &host_res);
>> +    remote_idx = zynqmp_ipi_mbox_get_buf_res(node, "msg", &remote_res);
>> +
>> +    /*
>> +     * Only set up buffers if both sides claim to have msg buffers.
>> +     * This is because each buffered IPI's corresponding msg buffers
>> +     * are reserved for use by other buffered IPI's.
>> +     */
>> +    if (!host_idx && !remote_idx) {
>> +        u32 host_src, host_dst, remote_src, remote_dst;
>> +        u32 buff_sz;
>> +
>> +        buff_sz = resource_size(&host_res);
>> +
>> +        host_src = host_res.start & SRC_BITMASK;
>> +        remote_src = remote_res.start & SRC_BITMASK;
>> +
>> +        host_dst = (host_src >> DST_BIT_POS) * DEST_OFFSET;
>> +        remote_dst = (remote_src >> DST_BIT_POS) * DEST_OFFSET;
>> +
>> +        /* Validate that IPI IDs is within IPI Message buffer space. */
>> +        if (host_dst >= buff_sz || remote_dst >= buff_sz) {
>> +            dev_err(mdev,
>> +                "Invalid IPI Message buffer values: %x %x\n",
>> +                host_dst, remote_dst);
>> +            return -EINVAL;
>> +        }
>> +
>> +        tx_mchan->req_buf = devm_ioremap(mdev,
>> +                         host_res.start | remote_dst,
>> +                         IPI_BUF_SIZE);
>> +        if (!tx_mchan->req_buf) {
>> +            dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
>> +            return -ENOMEM;
>> +        }
>> +
>> +        tx_mchan->resp_buf = devm_ioremap(mdev,
>> +                          (remote_res.start | host_dst) +
>> +                          RESP_OFFSET, IPI_BUF_SIZE);
>> +        if (!tx_mchan->resp_buf) {
>> +            dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
>> +            return -ENOMEM;
>> +        }
>> +
>> +        rx_mchan->req_buf = devm_ioremap(mdev,
>> +                         remote_res.start | host_dst,
>> +                         IPI_BUF_SIZE);
>> +        if (!rx_mchan->req_buf) {
>> +            dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
>> +            return -ENOMEM;
>> +        }
>> +
>> +        rx_mchan->resp_buf = devm_ioremap(mdev,
>> +                          (host_res.start | remote_dst) +
>> +                          RESP_OFFSET, IPI_BUF_SIZE);
>> +        if (!rx_mchan->resp_buf) {
>> +            dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
>> +            return -ENOMEM;
>> +        }
>> +
>> +        tx_mchan->resp_buf_size = IPI_BUF_SIZE;
>> +        tx_mchan->req_buf_size = IPI_BUF_SIZE;
>> +        tx_mchan->rx_buf = devm_kzalloc(mdev, IPI_BUF_SIZE +
>> +                        sizeof(struct zynqmp_ipi_message),
>> +                        GFP_KERNEL);
>> +        if (!tx_mchan->rx_buf)
>> +            return -ENOMEM;
>> +
>> +        rx_mchan->resp_buf_size = IPI_BUF_SIZE;
>> +        rx_mchan->req_buf_size = IPI_BUF_SIZE;
>> +        rx_mchan->rx_buf = devm_kzalloc(mdev, IPI_BUF_SIZE +
>> +                        sizeof(struct zynqmp_ipi_message),
>> +                        GFP_KERNEL);
>> +        if (!rx_mchan->rx_buf)
>> +            return -ENOMEM;
>> +    } else {
>> +        /*
>> +         * If here, then set up Bufferless IPI Channel because
>> +         * one or both of the IPI's is bufferless.
>> +         */
>> +        tx_mchan->req_buf = NULL;
>> +        tx_mchan->resp_buf = NULL;
>> +        tx_mchan->rx_buf = NULL;
>> +        tx_mchan->resp_buf_size = 0;
>> +        tx_mchan->req_buf_size = 0;
>> +
>> +        rx_mchan->req_buf = NULL;
>> +        rx_mchan->resp_buf = NULL;
>> +        rx_mchan->rx_buf = NULL;
>> +        rx_mchan->resp_buf_size = 0;
>> +        rx_mchan->req_buf_size = 0;
>
> Just curious if this is really needed. If none fills that values aren't they actually already 0/NULL because that location is cleared by kzalloc.
>
> Thanks,
> Michal

Confirmed. I removed the whole else condition and it still worked.

Will update in next rev after I receive any pending feedback from Jassi


