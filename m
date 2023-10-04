Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CA37B986A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239644AbjJDWy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbjJDWy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:54:28 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495A795;
        Wed,  4 Oct 2023 15:54:23 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-79fca042ec0so17858539f.3;
        Wed, 04 Oct 2023 15:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696460062; x=1697064862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+o+B82Y+YrrjStnUbXApQ7m5ApiTPP6Y7TOGENAVUx4=;
        b=MJjPBzlBvjK3estS4J4ciDvxbNxUd2xtLg/odqBH93R6h/LUUo1s2Vzcjt9f6m5dfU
         zxrBlj33hFysxermPBnZp5JWn9YJ7M8GzvrVCVGwGyvwM8qlqfbroiUIUca9V0FmRsPc
         HqOo61taKVUNwclLYqi85RnuiGKP1KWCFF/6yogYVcpLh1jgo7UDbKGJtBbAylCcdSb4
         W6QwZcmApa21Gif9LUOvj4wc4IskNXP6qyQCrNrT8M4C0dkRB7Pfus4aaGJpREDcBegb
         4aEJTZMb4xzPVj8Nox0CFK6YWmdF3Tejm/6Rd6tvvscDwn9+WM37drzUMHaZS3uOqkmW
         8CJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696460062; x=1697064862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+o+B82Y+YrrjStnUbXApQ7m5ApiTPP6Y7TOGENAVUx4=;
        b=gleTv/C33k2o8UD0XAncJwl0skxxLGVmfXbbfBFVoR1nnGP9cnFFGvF2rXQC7yipBu
         JOuNA124EWASR3UT8CYJXK+tgS9WjI3CaD7urRE1hSKAElSH4I77e/OH5DZ4wJBBJcHx
         nxUurw4BKHW/uwkzWLW+YFHHAU2jSWRRr4rmrUdruTp3gz8oLxvISEA8/NLemU2C1YUa
         +8Sph0g3aWfa3r3Qr+E4Yp2P2uD4ejInFgZp5naJURpYwMD/tH9QPgyGjny/Jjvw64DK
         OpWZ8VybcmdkQiamSezlesaNFyWLzMoH4Yp19txtnaFGeOXI2cahg7a9Medg6ToLxfnx
         Ox4A==
X-Gm-Message-State: AOJu0YyiakKgcx6jHH10R8Gec14YYL42VWTbEtFWtWdbfuS28KcXOUZr
        gKZaqDmsU90XxXdRf2j6bA==
X-Google-Smtp-Source: AGHT+IEkl37xqr6RNZoI2Y9Q8rTSlixNzqstcG933gqOYCiHX5Knr6InDFu6r6Gv1FvWgFOvkT03vw==
X-Received: by 2002:a5d:8452:0:b0:795:2274:1f3f with SMTP id w18-20020a5d8452000000b0079522741f3fmr3942548ior.3.1696460062468;
        Wed, 04 Oct 2023 15:54:22 -0700 (PDT)
Received: from [192.168.1.3] ([161.97.241.227])
        by smtp.googlemail.com with ESMTPSA id c26-20020a6bfd1a000000b0076373f90e46sm25665ioi.33.2023.10.04.15.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 15:54:22 -0700 (PDT)
Message-ID: <94e2b77c-9cc4-534f-e650-06d7e0697f9f@gmail.com>
Date:   Wed, 4 Oct 2023 16:54:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] arch/x86: port I/O tracing on x86
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-serial <linux-serial@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org,
        andriy.shevchenko@linux.intel.com, rostedt@goodmis.org,
        quic_saipraka@quicinc.com
References: <b8eae358-a3b3-fd68-82f1-b2c53534b922@gmail.com>
 <2023100344-dart-jailbreak-c371@gregkh>
From:   Dan Raymond <raymod2@gmail.com>
In-Reply-To: <2023100344-dart-jailbreak-c371@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/2023 6:50 AM, Greg KH wrote:
>> +/*
>> + * We don't want the tracing logic included in the early boot modules (under
>> + * arch/x86/boot) so we check for their include guards here.  If we don't do
>> + * this we will get compiler errors.  These checks are not present in
>> + * arch/x86/include/asm/msr.h which contains similar tracing logic.  That is
>> + * possible only because none of the msr inline functions are instantiated in
>> + * the early boot modules.  If that changes this issue will need to be addressed
>> + * there as well.  Therefore it might be better to handle this centrally in
>> + * tracepoint-defs.h.
>> + */
>> +
>> +#if defined(CONFIG_TRACEPOINTS) && !defined(BOOT_COMPRESSED_MISC_H) && !defined(BOOT_BOOT_H)
> 
> I see what you are doing here in trying to see if a .h file has been
> included already, but now you are making an assumption on both the .h
> file ordering, and the #ifdef guard for those .h files, which are
> something that we almost never remember or even consider when dealing
> with .h files files.

With one exception io.h is included from boot.h or misc.h which is where
the include guards are defined:

# find arch/x86/boot -type f -print0 | xargs -0 grep "#include.*[^a-z]io\.h"
arch/x86/boot/boot.h:#include "io.h"
arch/x86/boot/compressed/misc.h:#include "../io.h"
arch/x86/boot/compressed/tdx.c:#include "../io.h"
arch/x86/boot/io.h:#include <asm/shared/io.h>

I agree this is fragile but the problem is not confined to this patch.
If I add a call to rdmsr() or wrmsr() in arch/x86/boot/compressed/misc.c
I get the same compiler error.  It has something to do with the inline
assembly inside arch/x86/include/asm/jump_label.h.

I've copied Steven Rostedt who is the maintainer of tracefs to see if he
has any comment.  I just noticed arch/x86/boot/msr.h and I see that it
redefines rdmsr() and wrmsr() and omits the tracepoints.  A comment there
explains:

/*
 * The kernel proper already defines rdmsr()/wrmsr(), but they are not for the
 * boot kernel since they rely on tracepoint/exception handling infrastructure
 * that's not available here.
 */

We could do something similar for inb()/outb() and redefine them in
arch/x86/boot/io.h instead of including <asm/shared/io.h> there.

> Who wants/needs port tracing these days?  What types of systems still
> rely on that for their primary form of I/O other than some old-school
> serial ports?
> 
> The MMIO tracing was added because there are crazy out-of-tree SoC
> devices out there that "insisted" that they need to hook into the mmio
> access path, so they added traceing there under the auspicious of trying
> to log all mmio accesses so that they could then override the access
> path in the tracehook to do who-knows-what other things.  Hopefully you
> are not wanting to do the same thing here as well?
> 
> And have you addressed all of Peter's previous review comments?

The author of the CONFIG_TRACE_MMIO_ACCESS feature (Sai Prakash Ranjan)
stated that he uses it for debugging unclocked register accesses on ARM.
Andy Shevchenko mentioned that he has used MMIO tracing for tracing
memory-mapped UARTs on x86.  I was motivated to create this feature to
debug UART problems in an environment that runs Linux on a Celeron-based
SBC which uses port-mapped UARTs.

This feature can also be used for other things besides UARTs.  Things
like the PIT and interrupt controller use port-mapped I/O.  I work on
an embedded system that uses an ISA card cage to connect peripherals
to our SBC and all communication over the ISA bus uses port I/O.

Yes, I believe I have addressed all of Peter's review comments:

1) cannot use early_console->write()

   That is not true.  Everything that includes boot.h (ie.
   'arch/x86/boot/early_serial_console.c') will not change due to the
   '#ifdef BOOT_BOOT_H' guard.  Also tracing will not be compiled in
   unless 'CONFIG_TRACEPOINTS' is true.  Finally, tracing will be
   disabled at boot until the user mounts the tracefs and explicitly
   enables 'portio' events.  When tracing is disabled a nop
   instruction is used in lieu of a jmp instruction to avoid
   executing any trace code.

2) tracing relies on RCU which might not be alive yet and might
   itself be the problem

   RCU is not needed unless/until tracing is enabled.  I also
   demonstrated that port I/O tracing works correctly during boot by
   testing this patch with "trace_event=portio" on the command line.

>>  obj-$(CONFIG_SMP) += msr-smp.o cache-smp.o
>> +obj-$(CONFIG_TRACEPOINTS) += trace_portio.o
> 
> So this is always enabled?  No separate config option?  Why not?

The CONFIG_TRACE_MMIO_ACCESS feature has a separate config option
but it incurs a significant amount of overhead.  For example
mem32_serial_out() comprises 4 instructions (12 bytes) when
CONFIG_TRACE_MMIO_ACCESS is false.  It comprises 33 instructions
(101 bytes) when CONFIG_TRACE_MMIO_ACCESS is true and all of those
instructions are executed (including two function calls) whether
tracing is enabled or not.

This feature incurs much less overhead.  For example io_serial_out()
comprises 4 instructions (6 bytes) when CONFIG_TRACEPOINTS is false.
It comprises 14 instructions (34 bytes) when CONFIG_TRACEPOINTS is
true but only two of the extra instructions are executed when
tracing is disabled (and neither of them are branches).  The
extra instructions for tracing are marked with *** below:

c104e740 <io_serial_out>:
c104e740:  01 c2                 add    edx,eax
c104e742:  88 c8                 mov    al,cl
c104e744:  0f b7 d2          *** movzx  edx,dx                           ***
c104e747:  ee                    out    dx,al
c104e748:  3e 8d 74 26 00    *** lea    esi,ds:[esi+eiz*1+0x0]           ***
c104e74d:  c3                    ret
    
c104e74e:  66 90             *** xchg   ax,ax                            ***
c104e750:  55                *** push   ebp                              ***
c104e751:  0f b6 c1          *** movzx  eax,cl                           ***
c104e754:  89 e5             *** mov    ebp,esp                          ***
c104e756:  b9 62 00 00 00    *** mov    ecx,0x62                         ***
c104e75b:  e8 80 1e 33 00    *** call   c13805e0 <do_trace_portio_write> ***
c104e760:  5d                *** pop    ebp                              ***
c104e761:  c3                *** ret                                     ***

This is similar to the tracing overhead of rdmsr()/wrmsr() which
does not have a separate config option.

>> +/* SPDX-License-Identifier: GPL-2.0+ */
> 
> Why "+"?  (I have to ask).
> 
>> +/* SPDX-License-Identifier: GPL-2.0-only */
> 
> This is -only, which is fine, but your patch doesn't seem to be uniform
> here for new files being added in the same patch, right?  So documenting
> this somewhere (i.e. in the changelog), is essential.

I did not intend to be inconsistent.  I can make them both GPL-2.0-only if
that is preferred.

>> +DECLARE_EVENT_CLASS(portio_class,
>> +	TP_PROTO(u32 value, u16 port, char width, long ip_addr),
> 
> Memory locations are stored in "unsigned long" not "long", right?

It doesn't matter since "unsigned long" is the same size as "long".
I should use "void *" here but that will require a cast at the call
sites because for some reason _RET_IP_ is casting the pointer to
"unsigned long".

>> +	TP_printk("port=0x%04x value=0x%0*x %pS",
>> +		__entry->port,
>> +		__entry->width == 'b' ? 2 :
>> +		__entry->width == 'w' ? 4 : 8,
>> +		__entry->value, (void *)__entry->ip_addr)
> 
> Logging kernel memory locations, why?  Where is this format documented?

I borrowed this technique from the CONFIG_TRACE_MMIO_ACCESS feature.
It indicates from where the port access originated which can be
useful.  For example, it will reveal problems caused by two sections
of code accessing the same resource simultaneously.  It can also be
used for trace filtering or triggering.  The "%pS" format is
documented here:

   https://www.kernel.org/doc/Documentation/printk-formats.txt

Here is an example of the output:

   <idle>-0       [000] d.s2.   244.534473: portio_read: port=0xeb12 value=0x0080 uhci_check_ports+0x7c/0x2a0
   <idle>-0       [000] d.s2.   244.534474: portio_read: port=0xeb10 value=0x0080 uhci_hub_status_data+0x2dc/0x4b0
   <idle>-0       [000] d.s2.   244.534475: portio_read: port=0xeb12 value=0x0080 uhci_hub_status_data+0x2dc/0x4b0
   my_app-90      [000] d..1.   244.545706: portio_write: port=0x02f9 value=0x07 io_serial_out+0x2d/0x30
   my_app-90      [000] d.h2.   244.545720: portio_read: port=0x02fa value=0xc2 io_serial_in+0x36/0x40
   my_app-90      [000] d.h3.   244.545722: portio_read: port=0x02fd value=0x60 io_serial_in+0x36/0x40
   my_app-90      [000] d.h3.   244.545725: portio_read: port=0x02fe value=0x00 io_serial_in+0x36/0x40
   my_app-90      [000] d.h3.   244.545727: portio_write: port=0x02f8 value=0xc9 io_serial_out+0x2d/0x30
   my_app-90      [000] d.h3.   244.545732: portio_write: port=0x02f9 value=0x05 io_serial_out+0x2d/0x30
   my_app-90      [000] d.h2.   244.545734: portio_read: port=0x02fa value=0xc1 io_serial_in+0x36/0x40
   <idle>-0       [000] d.s2.   244.590459: portio_read: port=0x0408 value=0x008e2dfc acpi_pm_read_verified+0x9a/0xb0
   <idle>-0       [000] d.s2.   244.590463: portio_read: port=0x0408 value=0x008e2e19 acpi_pm_read_verified+0x82/0xb0
   <idle>-0       [000] d.s2.   244.590464: portio_read: port=0x0408 value=0x008e2e1e acpi_pm_read_verified+0x6d/0xb0



