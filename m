Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438CD7EBB54
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 03:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbjKOCuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 21:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKOCuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 21:50:50 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2128.outbound.protection.outlook.com [40.107.223.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10458C8;
        Tue, 14 Nov 2023 18:50:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D80yyC/mrJsxoe6T2yMZnQxpkGPIouw9iOFdjnlHPrWWHzEwSW7b9OckWcmM2lZDDFcMPqcIws22H0MHXVWrTjNCi/Fr4dpgWxcJj2ggT4sl7dWxIBAyzp/0XG3Kn47BOKXvJGz1pKgt8Fe01BTb63qHQCURUY5AVOQew4cWTX0p4VqDElIajd133+wY4snQExrXf9y8zP3EeeAhUELObVttbxLzKwg9vFyXGvpA09sA2oAj7iSDT+Qbe+AIcwFnG7ziW3VK7n5kw48bykT2WR6uU6jxQa6EQ4v62DK7LEpzrkplw5K2yUNs+9gZHnwGrpEEbpH2Yjin5M0j2+PSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbmRPZEAUQ+C7mWqIi1WuYvrlNuNuBa/BMIswotowKM=;
 b=fvpzb4CXDdkjAGJbKi2n2C6h+YgXscLQuoEbvryhGZsyrH5f5gNxa30yJdpphacBzuWZjk+yDedhCzO8IkFj/PeKEORPn6rXYtjlqXkAp9hw/2TadlJ3FrMjXfF0CtxzXLjrwpLo5vWW0zaXuMnZ4lCJvtSyAYElVQV7h9xkN90vwAKreMDfdmMBWS+kDg1a4vouRTWx+YUOD53cOFK3A0bB4PvIPNEKECaclB5OYHb80144FSm58RibWj5Z2KnJbjEw/4eY4qdkxT9a2OvWx4jB2+eypGoESMCn3Gpv8KqyTI1PuJJGwP1zt+EnMoOddGyU5hUxcgTEdtkVidinGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbmRPZEAUQ+C7mWqIi1WuYvrlNuNuBa/BMIswotowKM=;
 b=O3W+vseykRmfLu1OJ15dMrJQVVa5StYfZt/ejnJCp3zomOL4Z2W2+ZeX5cRLX62Y49WvHAHtLEFLzF5EhCMWG2bQlKZjx2Ysd4Lp2D5XIQjr7YWiPDQqCau3LdnlYl2zhp0ZK7zTEqkTlvf9lTp8BGEnmmUSB48UU/lbcJ0Hqpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ni.com;
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by SJ2PR04MB8961.namprd04.prod.outlook.com (2603:10b6:a03:564::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 02:50:44 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::cc16:4fea:f400:c353]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::cc16:4fea:f400:c353%4]) with mapi id 15.20.7002.015; Wed, 15 Nov 2023
 02:50:44 +0000
Message-ID: <c6ea912f-d5ab-4761-813d-3b6b6be141cb@ni.com>
Date:   Tue, 14 Nov 2023 20:50:42 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tty: serial: Add RS422 flag to struct serial_rs485
Content-Language: en-US
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20231113094136.52003-1-crescentcy.hsieh@moxa.com>
From:   Brenda Streiff <brenda.streiff@ni.com>
In-Reply-To: <20231113094136.52003-1-crescentcy.hsieh@moxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0018.namprd05.prod.outlook.com (2603:10b6:610::31)
 To SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4973:EE_|SJ2PR04MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: 316fba47-e678-46ad-18bb-08dbe585a9a3
x-ni-monitor: EOP Exclude NI Domains ETR True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jP81LNLjsFlhmfPTzbyhwXX3fUY9R/woGrkSXmHLF9a3ChYFMKuUTzuSbAsEusISdq1dAsaO5yp+V208cPQYV1iwQ15AA2wj2EK9S+uvg2u8epqE/vr+h1qjjOMVI4QuuBkhc6JoaA3kNjS5iHVHPATjJrBK25WAcKwESV7TQZqJ+zNq0gsxISk44015O/PJRhpYG7i7zoffrN5t4CMG47qGDXVI1HxRI+pzitRLfSM/ZuYAjzPFRa9lMrIW0ld+67/WqcUydTRAXfLwomFCV/27s/i58p1RENfARMC4Kk0lGfCRXLLx0g7/KZhWiA6HNWNMjLqeP0keurmIJ+z5O07J/dexs0zClXqaeFProDrvPUKt3+aj8nqxh+hY3yt5rUxUXdoXUBFSWmeL158j5lghhmyxbQdZuDnLV3doDdGLBHYCzg35ypFUkn+Z6Ww7Y7wV9eKbwAGgyQF35iPQ2XkyiULT2lVS+iy/rpa3EnT4kHzK8SeEojAnOE4mToio8ni0dRa+VpBLmBUx3p8lpbKoilVpbdWbMkt7ejc0bDSTpXNEzxOLclE/OYdGyMq9ebZCHe1Ib0JdT4SWp1U4nieMlZb7TBdNQiGmpDYOrI/cPLtaw2xMLFFdm22iFlhYodCSNktKw12LC42a/sKbXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4973.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(31686004)(66899024)(4326008)(26005)(38100700002)(66946007)(66476007)(31696002)(66556008)(36756003)(86362001)(6512007)(83380400001)(2616005)(6506007)(53546011)(2906002)(110136005)(478600001)(316002)(44832011)(966005)(6486002)(5660300002)(8936002)(8676002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVcrVDE3UFcxd2w1T21adlRaajU5cjhkVzl1Ymh4K1diUS8rUmZBVlp5L01K?=
 =?utf-8?B?QlAvVHNNcit3dkMxa2JlYjFNZjc2b2JZMU9VcVo0WXIzcm8rVzV0bzR4QndJ?=
 =?utf-8?B?TDFwUkVENjRMY3N0NG5ORkFldEJzbHQxdE96NlF5Zk1xbjEvTTFZSDdzVnVp?=
 =?utf-8?B?SVB4Z2pVYXBvV3VQcFp6YW1WRzcwVS9uWTJPQkZYWFFPMHBDTVRpcVJCY1Vs?=
 =?utf-8?B?RmJoUldGa1ZNWFIwVjB3UGZKSWJHMlRiYWxtZjdyUHZPTEVmR2NmT3UxNVc2?=
 =?utf-8?B?Rzh0dmdqR1NuVmtxWHpmenJWRUpRTzMxNnZuVE1iL2syMWNJS2dmMFdoTEsw?=
 =?utf-8?B?SzQzN3lqUjR2KzA3TkVxZFN4RTc3cDJUeXQ5RDk1bHdLaUxIaFlWcHltNktO?=
 =?utf-8?B?ZnN5ZlpHSFo5elNmUEN0bHBNU3RSVThjaGljWlFoUWhNVTJaS255Y3RWWEFk?=
 =?utf-8?B?M2lKOFpMcGorZDVJTlVUTzIxcU9BbllaSHVXcjFWUXZCcDlVMjJ2SVliNzV4?=
 =?utf-8?B?dXROOXkySTc4TmdDOU05M3gzQUV3VEdiS2RIdEpLVHg1a1J6aGtkM1MvMVdY?=
 =?utf-8?B?MW8wWmFMSzhuZGx3RWtsL2ZwUUZpcE5vWnRRcXJpZGZqelBGT2xqa25jaVdQ?=
 =?utf-8?B?eVlFdW9hT0h6WmhndGxuQzl6emNzeThCb1lkV2xrdy9iZWFoUDVsSUZ1Q3Jo?=
 =?utf-8?B?eGFlMXZGb0paYXVuTmhmL1RjcDlISjROZENMSmRZKzVpYUN0YzhIczRMRWM0?=
 =?utf-8?B?MDk3L05pMHFFYWhyTFNScVBjaEhvYnZjaThOUWRSdUlsYTBwTlg5eW5IZ0FU?=
 =?utf-8?B?L3RpcER6QjBrWHg0WkNRL2Z4bDgyK1ZzcFJxeHk2ZnUrRjVxanNBOW1xWS92?=
 =?utf-8?B?alVibFcwUTZPb2JlVUpHWThKeGF1dXZUMTY4SXZVbURjN2p0SjBIYTJjUmtv?=
 =?utf-8?B?dXlxWVZRZjM3ZmY5ZjhKUkdYdEdQbjBrb2UzMnVUYVE3RzNDUTc3dFYxMGhr?=
 =?utf-8?B?YjZ5ZCtNVWlhRm9Yd2M5bjZkQVUrNlJ1NHlodTNkdVA5a1FweDNQMXd5WVVB?=
 =?utf-8?B?bTQ4UHI2Rk42cGs0NncvL0xMazIyZHhaRUx1OVZBcnJ3aURCM1VsZytxcnZS?=
 =?utf-8?B?a1FhYVpkaDd0enNoeU5SQ2VNK1BHc1BidEtGc2pZSWdnMklpSWxmeU5FQXRI?=
 =?utf-8?B?dmZUazE3WXJweWRzaGgrZ1dpRDhPeFJqYVdEdW43K3JpNk14V1RWZXpxK2M4?=
 =?utf-8?B?T2ZZaTI3SUFUQ3NHOXI4R1RSSDI2bEE4c0gxZlNMcmQ4dWRONEJIVUJCZm16?=
 =?utf-8?B?Y3d3aWQwbStYZXMzTCtudEorT1duNWk1VWlramxrVEtGQThQQXNoaFEyNkVL?=
 =?utf-8?B?N0g2QkhUTmtCdDZkRk53NXFmWkFYa2RXWmxndVNsSzFlWFgwWHdMNTBwamNE?=
 =?utf-8?B?WjljY3Zqcy8vZG1nNjQ3dGgvVG42cTlFRHRHNGk2TTZGbnFheHhPMFNZRWFN?=
 =?utf-8?B?M3ZFc0Z4djd4NEVqdlFnMXNxVGg0WjdVZmJ3RnZxc1d2K1hLeE1JV3h5cUV3?=
 =?utf-8?B?MUFQOEJiS0JiZFdVSHROMnVuRXp0SEx6ZlJTV1JXdEVTMElXMmgyRDRrQ2xV?=
 =?utf-8?B?cUlZNzhNMjdhNHNIOFJLa21SdEpRalF6N1FZd2MveW5SVlFLSjc4cUJLNWRh?=
 =?utf-8?B?b2FhdU1QaHBCMndKQkkzRkRoekRXZmFEV1lrbXNFTFMyeHNIbkVoVlo4V1Ez?=
 =?utf-8?B?OE9TWEplTS83d1lXUENoVWVkMUM3ZzZDc3k3QmZsa0MyMyt5VzRsMDhrRnQw?=
 =?utf-8?B?MmhEbmYvZlhXSmNZZ1dBaUxpZ09PakVNS1MzQzIyak9xZTJDVUJWTzgvOXhy?=
 =?utf-8?B?dFBtYlRkREJsYllEbVgvaDNKeHJIYm50YnNSU3NNcTRjcHJYMEt6S0JvdXRa?=
 =?utf-8?B?Ky90WEJMOGNjZnZYODY3M1Q5MDh6NmcwbVZvN1ZQdFpOQU9mekFid2VYeE9F?=
 =?utf-8?B?U1owbUdjcHdWRTRpYlg2ajh0SnphWk5nWlpKYmZuYmFybGxJbG83dTZHeExP?=
 =?utf-8?B?NXhFZDFCZGV3UjUrd3JlOVdqUzIrQVRMdlZpQ2lZZUtHT2txRjdlcDkwbUNM?=
 =?utf-8?Q?AIArNfK/fpjBmVuldak16lAn1?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 316fba47-e678-46ad-18bb-08dbe585a9a3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4973.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 02:50:44.4362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nCgMwcd/CgEQklO2bTOMscq1byTcoloQLz52F1IzRFlwD4XSWdvLn5GVFdfsNoGNNKQGd7QPKeTVQ09+PNapQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8961
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/13/2023 3:41 AM, Crescent CY Hsieh wrote:
> Add "SER_RS485_MODE_RS422" flag to struct serial_rs485, so that serial
> port can switch interface into RS422 if supported by using ioctl command
> "TIOCSRS485".
> 
> By treating RS422 as a mode of RS485, which means while enabling RS422
> there are two flags need to be set (SER_RS485_ENABLED and
> SER_RS485_MODE_RS422), it would make things much easier. For example
> some places that checks for "SER_RS485_ENABLED" won't need to be rewritten.
> 
> There are only two things need to be noticed:
> 
> - While enabling RS422, other RS485 flags should not be set.
> - RS422 doesn't need to deal with termination, so while disabling RS485
>   or enabling RS422, uart_set_rs485_termination() shall return.
> 
> Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
> > [...]
> diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
> index 53bc1af67..9086367db 100644
> --- a/include/uapi/linux/serial.h
> +++ b/include/uapi/linux/serial.h
> @@ -11,6 +11,7 @@
>  #ifndef _UAPI_LINUX_SERIAL_H
>  #define _UAPI_LINUX_SERIAL_H
>  
> +#include <linux/const.h>
>  #include <linux/types.h>
>  
>  #include <linux/tty_flags.h>
> @@ -137,17 +138,19 @@ struct serial_icounter_struct {
>   * * %SER_RS485_ADDRB		- Enable RS485 addressing mode.
>   * * %SER_RS485_ADDR_RECV - Receive address filter (enables @addr_recv). Requires %SER_RS485_ADDRB.
>   * * %SER_RS485_ADDR_DEST - Destination address (enables @addr_dest). Requires %SER_RS485_ADDRB.
> + * * %SER_RS485_MODE_RS422	- Enable RS422. Requires %SER_RS485_ENABLED.
>   */

Documentation/driver-api/serial/serial-rs485.rst could also use an update,
since it doesn't mention your new flag at all.

The documentation as it is also doesn't give a very good idea of what flags
userspace might need to set for RS-232 vs RS-422 vs RS-485 (2- or 4-wire).

If I compare this to your original patch set [1] for your hardware, then
your proposed flag would be used in the following ways, correct?

RS-232:                       rs485->flags = 0
RS-422:                       rs485->flags = SER_RS485_ENABLED|SER_RS485_MODE_RS422
RS-485 (2-wire half-duplex):  rs485->flags = SER_RS485_ENABLED
RS-485 (4-wire full-duplex):  rs485->flags = SER_RS485_ENABLED|SER_RS485_RX_DURING_TX

In iot2040_rs485_config in 8250_exar.c [2] we already seem to have:
RS-232:                       rs485->flags = 0
RS-422:                       rs485->flags = SER_RS485_ENABLED|SER_RS485_RX_DURING_TX
RS-485 (2-wire half-duplex?): rs485->flags = SER_RS485_ENABLED

This would seem to create an inconsistency in this API.

I've also been trying to get a driver for NI's serial hardware upstream [3]; we
have "RS-485" products that can do both RS-422/RS-485, and also have use of
functionality to toggle between the two modes, so-- whichever way this flag
goes-- I'd like to be consistent with how other drivers do it.

[1] https://lore.kernel.org/linux-serial/20231018091739.10125-7-crescentcy.hsieh@moxa.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/serial/8250/8250_exar.c?h=v6.6#n459
[3] https://lore.kernel.org/linux-serial/20231023210458.447779-3-brenda.streiff@ni.com/

