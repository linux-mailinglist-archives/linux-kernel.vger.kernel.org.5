Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A7E809F55
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 10:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573436AbjLHJ22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 04:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235826AbjLHJ2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 04:28:24 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2069.outbound.protection.outlook.com [40.92.53.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231321724;
        Fri,  8 Dec 2023 01:28:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJluaJqPUD/RkyjsHOOb/A0yjpeR25HAVhYAVTC2+bgbBS9c5w+HiPAAxk5MVMPtRXoc54wpCakBJTTagLeam9cJnIMwa9zyPBUc1M2EeOei/fYIrFOuuWtz0DZMhW/G5jktfdZ925C75jTUfzoR4iP28bqcS7oszP1XA69pBZYs5D65rb82avTkQYcoRsI9iVQWqnoNQaa1X5AwgK8+j6VXhBPfN17u+fluzRzQNlUmalZaJXKB4HHebg6EidBEJ5OxC5cxdYxGYcVspiUaL39ADrj6mamL9Rm/2ZCkyGreeQy5zn/1Zpv0mjYUI7RwbpTGAC1tXaHeh6tVtZi9mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1ehgflNPp7iDImx1FS4KRNVfjUBNygr0Cz5ozGzQ6Q=;
 b=iIySPCV5yHA219gVVEmSES6lYbHalGSRdZ4e/Z9DyqrM2eivCpi0Fi8WFBIdNoGfqZE/vHVETPU0e0lTiXISYp2dP0POKaGxtahntt2jF/v59Be66QqWJ1YoZOZ0YJ0Cyvs3LbeO0OUrVUcRWoe9MOmKBCxoq1TeTCbkFwLsjIQmWqsbRC7f/0SQTTufb+jA9jzq4dpZc1jvvsFW+chMuwf4TaQJHvQCaC/hwvdb3GQvkLr67aT2383GJSSL8eF3i9tshUyF8LWkxMlmtYgbeYZ82GLkM3WfccwhLiVfVLLC9z1FK1RT7uvARmVb6YXNgTw4BYM9mE/VtlRNdxI8DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1ehgflNPp7iDImx1FS4KRNVfjUBNygr0Cz5ozGzQ6Q=;
 b=HKMUt5lQC9EUuHqUl9fpbedYGE97GT3d38dEDQdMTxL8wBUsH0/o1ir0Epr3qnMHJbUiJ6BfCWveOjVB/0F4moc9tBKOSzDppz/aH0HTx7U0p6Mqxrt5Up/1qIMweiyFbJchTSImAo/7hBT+2N5lW06XrCFPek2H/ZEZDdsjB1+GiOBa8W8NKl3x5pm+05v/X91SxvMkE59aqa1cT+PB5sm7EnWJU1SFHsubve66c3REQK4S7hRnU2dsGEw8gjlMl3hVPZILTWoyrY4QPiiLkfMBl5biAtN52DxPYCUlNJIPZh3RckDHyGkS1stH/1S3hD0NFE6RHiTk6/SolNnIZA==
Received: from TYZPR01MB4784.apcprd01.prod.exchangelabs.com
 (2603:1096:400:28d::9) by SG2PR01MB4363.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.26; Fri, 8 Dec
 2023 09:28:24 +0000
Received: from TYZPR01MB4784.apcprd01.prod.exchangelabs.com
 ([fe80::5074:605e:7b60:3ad4]) by TYZPR01MB4784.apcprd01.prod.exchangelabs.com
 ([fe80::5074:605e:7b60:3ad4%5]) with mapi id 15.20.7068.026; Fri, 8 Dec 2023
 09:28:24 +0000
Message-ID: <TYZPR01MB47847CC913E498B31755C9A8D58AA@TYZPR01MB4784.apcprd01.prod.exchangelabs.com>
Date:   Fri, 8 Dec 2023 17:28:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb:xhci: Avoid hub_event() stuck when xHC restore state
 timeout
Content-Language: en-US
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        mathias.nyman@intel.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianyaxiong@kylinos.cn, gregkh@linuxfoundation.org
References: <TYZPR01MB4784CB3058AC1B5787DB6601D586A@TYZPR01MB4784.apcprd01.prod.exchangelabs.com>
 <f02353be-4e51-aad2-08ee-d44b3693f061@linux.intel.com>
From:   Yaxiong Tian <iambestgod@outlook.com>
In-Reply-To: <f02353be-4e51-aad2-08ee-d44b3693f061@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [Q9vmU/HaKrV+1kb7U7+pv/aBVZDKGD8tAxG79p2jwtDFwkNf0ZpT6c0h1RgZY4hw]
X-ClientProxiedBy: TYCPR01CA0185.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::11) To TYZPR01MB4784.apcprd01.prod.exchangelabs.com
 (2603:1096:400:28d::9)
X-Microsoft-Original-Message-ID: <97844ba0-988a-4150-a95e-dfd8b3515510@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB4784:EE_|SG2PR01MB4363:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e893e34-6eb1-4e6f-a876-08dbf7d006e2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: in0+3eESm7UDeM0PmglXcPiGI1ChED1KcLFO34rTxKel2bAOtviW0tcbLF8EKUhHeC/lH3919Tqgrhnm1Ui2n72rDMD19CR5QDvn4c0R1v+0DHwWa49a6uQmrx/nYwMEvXf1YN5O/aj8/0HOnlQultYaTeEEqlR8Rj1PhISgFS5UzK8DlsIZ5XMkuvwvE5Z0leXvmVX7UumUo48dUuZF9tSH4qdbg4pMGvdeHjM46Q4GwKNaSnlZzwN24vrJR0fSDNslm9N/+KG170dp1b2gKtVfsmQQdBMPUAo4qCFFxZdImjiq5IX/zwWLatPEXntqk6cAIYiD4uzHw+vpGDWY1+wh+gci8Lo3dOnWmd0mbi9L7OGaSFkkxlS2XpDeMCeCXrXFoVswCbOY0AAI8cxpV4VMS2MAQaZOpgkrD/Y9+SRWEOXJNvGN3/X3IvNYnSyTDQc/cok5/UbKdXw1UUyisJreOoVqW4RXzDh24dG1E5QwbG6rQY1j+dbHg0yRzXQD6fbQZqqWspizMKsQV49Mk6BdqHV18y0lvmMhcIYZ6vSY9Rb4sIAx2ytE5BrHU8fe
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emhrdm5MbzNxdnZMalRQQndBS2s1NytCaWdSczZxZko3TjM4bk9MZTNJQ2d3?=
 =?utf-8?B?RGVZdTJ0S2VSTUJHVzd0K3JhNTNPbndDVWhIbndCQTRpZ01DTlZGUUdXQWw4?=
 =?utf-8?B?Zjk0ZlJkUmF5ZzJYOUM3akxzdm40ZUFWeGtxdmdBUTVSMmhCM1B0UndQa3po?=
 =?utf-8?B?dWc0VGRFMGlVSkJobVdDM2lkdTJkTGxGRXlRODkyWjRBeXFEQ2xGN3BySS9C?=
 =?utf-8?B?amZjU2ZML0JZVEhWYnVjdkZocGJtdmVPT2hDMzViTlVDNkRIdTNjZ2JtU2pD?=
 =?utf-8?B?R2p6WTNiUzB4bmhxUDc3WjM5b2NhbEZVM2ZCME9rcnVmd1IzcjFVNTNTdGJs?=
 =?utf-8?B?Q1pFUGpEWG5VOGREcVliQkZSZWZ2M3VJZ21NQThmMk1JZk41R2t2MFVNZmI0?=
 =?utf-8?B?eHJpYyt4UTZJaGhaVmFBeG1PcXlmaTQydUM4STVQMnZvQW9pZWVUN1BuN3Yw?=
 =?utf-8?B?aVUwZ3BEa01IWE1teWsxNUZTV1UxUUp4dWltRmtKT0E3L3hQdHR6T2hlWkgv?=
 =?utf-8?B?WkRMYzhtSjMxVGFYQ1krVjlDcjJsSmt2c1prcE96NmJ5WGU3SXVXNVU4ZVB1?=
 =?utf-8?B?Yi85UVFPVjF5Sy8vc2dIc21YbHhwY3laK2JaeVJmRDVIclFQTnM2bVU5RDdP?=
 =?utf-8?B?WGQ4Y1krWG5peEtFWlI0OGJZN3FqWE9LaEQ2NGZmSFoyUHdIdlcxS1NPZlhR?=
 =?utf-8?B?eGttazB3WVkvZjF0a3JZNjVCWmQ0RnhpekVEbHdlKzgxRW1WK1RVYUJuSmU4?=
 =?utf-8?B?emRBNXlydHNSa29WeEszSW81VjVkR0pYdFJNU1pxKzFjbW53SHJIVkd4UjNj?=
 =?utf-8?B?YVFtYVIwYkxFdnhEV2hBYjBMYzNXNzVmU0UzbjJ1bmtCSGUyRVRUWFUxeTBw?=
 =?utf-8?B?L0pwMGR0TDduZHRJTml1bVFocGtFajZMUkRnYXA2NkhvTkxkT0hWYWw5NTlm?=
 =?utf-8?B?V1lqVUo0V20yK2VZbXR3cEs2SW5wS2RQYjZQNWhISndRWmJSQm9TUlM4NlFv?=
 =?utf-8?B?N0x1cHVDZ2Rra3kvOWdvdUU5UWZXRHB4Z1RoK1hFelIrZXlieDhlT3pINGln?=
 =?utf-8?B?NHlXbVpkM3h3bUNJVHp5clRkVEdaTlJhZUUybHRtVlpNVUpyTGkxaW1VcnhE?=
 =?utf-8?B?amdGR1VHOEdiSFFjenZ4ckJkVUhnUGhSck9oZ2djcmhJS2RQcDlVWkxHZVdt?=
 =?utf-8?B?UFpOUUx1b1NQQTlueHRINnl2S3pUYWw0TlNOcXZEaFZheEdCOTI0aGoyQ2Qr?=
 =?utf-8?B?cno0Z2ZZZG5PS20zck51Tk1ueTdua2pvazd6ZE1sanhZRGV0MURqMWdPS3lW?=
 =?utf-8?B?eXV2ODZvclk3TFo3amJQUUNsWnp0aDR1RnpLejU0cFc3RStGMVVDTFFLQlhn?=
 =?utf-8?B?Y2xDM0tPOUhUdmlPWEJkbk42QmlPa2JraXhMNHJpdGJyYW10VitmbjkyeDlR?=
 =?utf-8?B?NEkrTFY4VHMwQnRSTlgzelZweGhidWgvMlRON2tub1k0cUNCdUxKcHJPT0Qz?=
 =?utf-8?B?ZGdBMmFEdGl2OUtYbGpTdWVvZEg4eVhORTJhdkR1ZSs4eTdxTnpZTno2WVR6?=
 =?utf-8?B?MWFjdnVNc01lOGg1WGlLNUxhaE1iRENGSWlaWHdSTkcybkR1WnJJWFR0NWVn?=
 =?utf-8?B?U3p4c2RHM0JDeEZsUXdvUmdsQTVrNm5zeGZmQ0drbEFtWXNwMGlNOEt4Q2dZ?=
 =?utf-8?B?dTFNc3doWHBuM2w4YVU1ZTlrdkZ1ZW1hdG54UHB0UFAya2luTVUyWnVYdlVU?=
 =?utf-8?Q?VASlGadl4ZBp0PaIjg=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e893e34-6eb1-4e6f-a876-08dbf7d006e2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB4784.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 09:28:24.5501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB4363
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/12/5 22:58, Mathias Nyman 写道:
> On 4.12.2023 10.02, Yaxiong Tian wrote:
>> From: Yaxiong Tian <tianyaxiong@kylinos.cn>
>>
>> when xHc restore state timeout,the xhci_reusme() return -ETIMEDOUT
>
> Out of curiosity, have you tried if it still is possible to revive your
> xHC controller here?
>
> Instead of returning -ETIMEDOUT, try setting " reinit_xhc = true", and
> jump to  "if (reinit_xhc) {"  where we reinitialize xHC in 
> xhci_resume() due
> to other resume issues.
Yes it is works.
>
>> instantly. After usb_hc_died() called ,they kick hub_wq to running
>> hub_event() but the wq is freezd. When suspend ends,hub_evnet realy
>> running and sticking.
>> Such as:
>> [  968.794016][ 2] [   T37] "echo 0 > 
>> /proc/sys/kernel/hung_task_timeout_secs"
>> disables this message.
>> [  968.802969][ 2] [   T37] kworker/2:3     D    0   999      2 
>> 0x00000028
>> [  968.809579][ 2] [   T37] Workqueue: usb_hub_wq hub_event
>> [  968.814885][ 2] [   T37] Call trace:
>> [  968.818455][ 2] [   T37]  __switch_to+0xd4/0x138
>> [  968.823067][ 2] [   T37]  __schedule+0x2dc/0x6a0
>> [  968.827680][ 2] [   T37]  schedule+0x34/0xb0
>> [  968.831947][ 2] [   T37]  schedule_timeout+0x1e0/0x298
>> [  968.837079][ 2] [   T37]  __wait_for_common+0xf0/0x208
>> [  968.842212][ 2] [   T37]  wait_for_completion+0x1c/0x28
>> [  968.847432][ 2] [   T37]  xhci_configure_endpoint+0x104/0x640
>> [  968.853173][ 2] [   T37]  xhci_check_bandwidth+0x140/0x2e0
>> [  968.858652][ 2] [   T37]  usb_hcd_alloc_bandwidth+0x1c8/0x348
>> [  968.864393][ 2] [   T37]  usb_disable_device+0x198/0x260
>> [  968.869698][ 2] [   T37]  usb_disconnect+0xdc/0x3a0
>> [  968.874571][ 2] [   T37]  usb_disconnect+0xbc/0x3a0
>> [  968.879441][ 2] [   T37]  hub_quiesce+0xa0/0x108
>> [  968.884053][ 2] [   T37]  hub_event+0x4d4/0x1558
>> [  968.888664][ 2] [   T37]  kretprobe_trampoline+0x0/0xc4
>> [  968.893884][ 2] [   T37]  worker_thread+0x4c/0x488
>> [  968.898668][ 2] [   T37]  kthread+0xf8/0x128
>> [  968.902933][ 2] [   T37]  ret_from_fork+0x10/0x18
>>
>> The result is that you cannot suspend again.because the wq can't
>> be freezed.Also hard to reboot,when some application visited this
>> piece.
>>
>> The reason of stuck is that some access related to xhci hardware
>> is being called.But xhci has problem,at least not running.(
>> when xhci_restore_registers(),the xhci will load op_regs.The
>> CMD_RUN will clear in xhci_suspend().)
>>
>
> Nice catch and debugging work btw.
>
Thanks, I further debug found that the command is Infinite 
retransmission and xHc is
halted. So the __wait_for_common() never complete,because xHc is halted 
and others
don't kown.
Note:For fast reproduction  I force  return -ETIMEDOUT  by setting
      if (1 || xhci_handshake(&xhci->op_regs->status,STS_RESTORE, 0, 100 
* 1000)) ）

[  131.024013][ 3] [  T135] xhci_hcd 0000:06:00.0: Command timeout, 
USBSTS: 0x00000001 HCHalted
[  131.032447][ 3] [  T135] xhci_hcd 0000:06:00.0: Command timeout on 
stopped ring
[  131.039745][ 3] [  T135] xhci_hcd 0000:06:00.0: Turn aborted command 
00000000620a076c to no-op
[  131.048346][ 3] [  T135] xhci_hcd 0000:06:00.0: // Ding dong

>> So using XHCI_STATE_DYING flag,to avoid any code to touching
>> hardware immediately.hub_event() will complete.The usb_hc_died
>> tasks will be completed and some sys interfaces will be removed.
>
> The XHCI_STATE_DYING flag is currently only set in xhci_hc_died().
> So when this flag is set we could assume that the command ring and
> pending URBs are, or will be cleaned up. This would change with your 
> patch.
>
I agree it.
> We might need some other solution,
> Maybe set the set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags) after
> CNR (Contorller Not Ready) is successfully cleared, and controller is
> actually accessible.
>
> We then would need to add checks to see if controller is accessible
> before queuing any commands to xHC hardware.
>
I found another fix based on the debugging results。In xhci_suspend() set
xhci->xhc_state |= XHCI_STATE_HALTED and in xhci_resume() clear it.
like it.

------>8-----
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 08fbabff23a0..f364958c237a 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -928,6 +928,8 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
          spin_unlock_irq(&xhci->lock);
          return -ETIMEDOUT;
      }
+    xhci->xhc_state |= XHCI_STATE_HALTED;
+
      xhci_clear_command_ring(xhci);

      /* step 3: save registers */
@@ -1119,8 +1121,14 @@ int xhci_resume(struct xhci_hcd *xhci, 
pm_message_t msg)
      command = readl(&xhci->op_regs->command);
      command |= CMD_RUN;
      writel(command, &xhci->op_regs->command);
-    xhci_handshake(&xhci->op_regs->status, STS_HALT,
-          0, 250 * 1000);
+    if(xhci_handshake(&xhci->op_regs->status, STS_HALT,
+          0, 250 * 1000)){
+        xhci_warn(xhci, "WARN: xHC CMD_RUN timeout\n");
+        spin_unlock_irq(&xhci->lock);
+        return -ETIMEDOUT;
+    };
+
+    xhci->xhc_state &= ~XHCI_STATE_HALTED;

      /* step 5: walk topology and initialize portsc,
       * portpmsc and portli
----8<-------------

> Thanks
> Mathias
Thanks
