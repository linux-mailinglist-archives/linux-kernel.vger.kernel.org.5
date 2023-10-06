Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064177BC124
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbjJFV3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjJFV3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:29:22 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7023CBD;
        Fri,  6 Oct 2023 14:29:21 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-351250be257so10950465ab.0;
        Fri, 06 Oct 2023 14:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696627761; x=1697232561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QKtdl+mkSpZ9AnEfysPfuyVzFCiNO5jLGUcOdP4QN2A=;
        b=L3ZjPGYvcpoM0N15SxB9fNHaK3sVs+syXWXcrF+7GXDsbecUb39OxqAKbM61wdFWjf
         gmgUP8ITuaZ1jvpBPZsKM4Uy2uo+oQ77XNK1DJurdiw2OE99WgXJNlq6io1UwKWt+wmj
         w0IR/cL/GsFjs4TEkpF/0tnkc8pfGAqncgL7na6twVbr1thylAnCie0NoUW027q4x/Jy
         LBIsNb5JA8myeJJjX/mBJW8INH28m4QR/dfqSr/RH91ctCMr9Mtmoc7SAnT/gGTL+VxQ
         UlSco2X250Kt3PNi/kyVMO0D68z5S8oNXUSbjknN8QBKS0rBMK+8aRMpFtvZJPphPzNo
         Kzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696627761; x=1697232561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKtdl+mkSpZ9AnEfysPfuyVzFCiNO5jLGUcOdP4QN2A=;
        b=l/OslTrfbc+7mWUtFPzs240l8hdsXSxObTaB7CzMVYgQh9SQ2PXS6lmlm1h60m/BTL
         U1B7kNmyZob3jQW+8bXztEej7Z994C+u0mau2ZTrg5fA19tV/TXIyzYh/Eula94QGc0O
         KKzqj9OPR21/Y6x/7YUpb2+P2NJBhRB0YZXYbW/CNQSXViXkR5u6F2/Q9uPOaEiJE8Kv
         j1gu0hn4UhoEHFFzfIlGrHYMUl+Uv80CIMTYkvoqaukghjw1ZegSyiN2xDNeHn8r1ie3
         drA4czhbxPX5wKx83PqLYbQXDWRJmHpMMEhCKDoxHEk4pP17sm91OQiF+pH9h2zBOIgv
         F+8A==
X-Gm-Message-State: AOJu0YzjAf8q8iawCpIiYv0ODy6CIX2YMgVT5PjTb623CONU1/VXm8NF
        G28ZB0CcLDiOqhNOSgzhig==
X-Google-Smtp-Source: AGHT+IGjhWseGC+WWhmaWr0+1K/Mt9+4DThJaPiuhPIxFpXHdz5HqgvnteItSCjmCToDoDxvLQPILg==
X-Received: by 2002:a05:6e02:1d15:b0:351:ab2:2626 with SMTP id i21-20020a056e021d1500b003510ab22626mr10176255ila.24.1696627760688;
        Fri, 06 Oct 2023 14:29:20 -0700 (PDT)
Received: from [192.168.1.3] ([161.97.241.227])
        by smtp.googlemail.com with ESMTPSA id p4-20020a92d684000000b0035146678bd5sm1307076iln.65.2023.10.06.14.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 14:29:20 -0700 (PDT)
Message-ID: <3d30d1b1-e4a2-7af3-20ef-11d2d97f65ad@gmail.com>
Date:   Fri, 6 Oct 2023 15:29:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] arch/x86: port I/O tracing on x86
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-serial <linux-serial@vger.kernel.org>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        andriy.shevchenko@linux.intel.com, quic_saipraka@quicinc.com
References: <b8eae358-a3b3-fd68-82f1-b2c53534b922@gmail.com>
 <2023100344-dart-jailbreak-c371@gregkh>
 <94e2b77c-9cc4-534f-e650-06d7e0697f9f@gmail.com>
 <20231004195001.76a57417@gandalf.local.home>
Content-Language: en-US
From:   Dan Raymond <raymod2@gmail.com>
In-Reply-To: <20231004195001.76a57417@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/2023 5:50 PM, Steven Rostedt wrote:
>> I've copied Steven Rostedt who is the maintainer of tracefs to see if he
>> has any comment.  I just noticed arch/x86/boot/msr.h and I see that it
>> redefines rdmsr() and wrmsr() and omits the tracepoints.  A comment there
>> explains:
>>
>> /*
>>  * The kernel proper already defines rdmsr()/wrmsr(), but they are not for the
>>  * boot kernel since they rely on tracepoint/exception handling infrastructure
>>  * that's not available here.
>>  */
>>
>> We could do something similar for inb()/outb() and redefine them in
>> arch/x86/boot/io.h instead of including <asm/shared/io.h> there.
> 
> That would be a saner approach.
> 
> -- Steve

I tried this but it is problematic because there are include chains that
define inb()/outb() without including arch/x86/boot/io.h at all.  For example:

  arch/x86/boot/compressed/misc.c ->
  arch/x86/boot/compressed/misc.h ->
  include/linux/acpi.h ->
  include/acpi/acpi_io.h ->
  include/linux/io.h ->
  arch/x86/include/asm/io.h ->
  arch/x86/include/asm/shared/io.h

What we need is to disable tracepoints altogether in arch/x86/boot/* so I
added -DDISABLE_TRACEPOINTS to the relevant Makefiles and I added a check for
that symbol in tracepoint-defs.h.  I will submit a v4 version of my patch
with these changes shortly.

This resolves the problem with <asm/msr.h> as well.  After applying the v4
patch I was able to call rdmsr()/wrmsr() from arch/x86/boot/misc.c.
Theoretically we can now remove arch/x86/boot/msr.h but I had trouble with
that due to compiler warnings and errors.  The include files in arch/x86/boot
are a mess.  Maybe this can be cleaned up in another patch.
