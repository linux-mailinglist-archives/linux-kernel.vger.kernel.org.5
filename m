Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4849C7FFF95
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377351AbjK3XlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377298AbjK3XlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:41:08 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360FD10E2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:41:14 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a00191363c1so210709566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1701387672; x=1701992472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XpIFViq80CAyZG/xM10+kcE0XfsC5rrXKGEu3AH6YcM=;
        b=ZA2uaVrRZhIij8atLsMODCTuin5FfGNc4QnmoXds4WdciD0DujmwHFHgxUbZAJ2dPt
         gvO5D/XUIUi4vUXlLZ0tkYPxSvny0lKTcb/eN0XLTeeKr4zgeIkLZkWnEHINmhOeCio1
         Pd+H5Q3vuVBoNbcSQxpt4JNFZL869JAyqNhug70zAf+cuA2qdd4yoxiYO7B7oc2o9xlA
         VyaGYdrnADitteY8rb2qzIC6UH9+UaJfOsKhw4AJJ3rkK9MBSHTWyioE+ubIEf5BWS+V
         JJ7qcAwDgPwRRE6TA2PsaU9zuLK8t/l/18LK1HbHo29aQISypcX7mlxdEbKxPwxw0jBL
         AkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387672; x=1701992472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpIFViq80CAyZG/xM10+kcE0XfsC5rrXKGEu3AH6YcM=;
        b=MgZbxHqw041XVdLllBUV8wS5Fg4rWXAsLW9v71lyk/X70oyd3/28zStRNfnXTvUpVY
         dVOkFvq5U+4M4v9X65YZJFTFHBBg/vyX6svd/F49p45ukCCErMw0oI9EopprtQ8rWVzM
         Jt735ROgYsPBzH+hkO5xM6mSIiCqTPx78ArKUmCX90ugIYq9+pBTTlQYo6LWYygZRo1+
         rQI+5v6i6slZQ5H8Rugh6REOCvfo+RaJIhNmx54RUjowZaU4En7mG5wscxE4gv6MhXIh
         RRn1mthaNtHTuMKeDTJTfLf30Zcujo8fcJ2n7EGqivtr1eXwcxU9HXI1Vh8VYOdntyvS
         AbfA==
X-Gm-Message-State: AOJu0YzaUPTLunq9d8QnyYekQiK8WrNvX96vEoIJI4yPJC4OZHhAydmZ
        /gs3ATgsImRuaYtKc0yCbBOeCFe/cq5+03kZxM9h
X-Google-Smtp-Source: AGHT+IF68wBGB/64avHRJ1SPDyuc2OUCqD0nbJnht+amFksCM2lEAI53Ys8B8yO6nPBmkKm1FpYP1w==
X-Received: by 2002:a17:906:103:b0:a19:d40a:d1ed with SMTP id 3-20020a170906010300b00a19d40ad1edmr68458eje.185.1701387672553;
        Thu, 30 Nov 2023 15:41:12 -0800 (PST)
Received: from ukaszb-l.semihalf.net (public-gprs368940.centertel.pl. [37.47.72.109])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906100900b009ddaf5ebb6fsm1210175ejm.177.2023.11.30.15.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 15:41:11 -0800 (PST)
From:   =?UTF-8?q?=C5=81ukasz=20Bartosik?= <lb@semihalf.com>
To:     Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Subject: [PATCH v2 00/15] dyndbg: add support for writing debug logs to trace
Date:   Fri,  1 Dec 2023 00:40:33 +0100
Message-ID: <20231130234048.157509-1-lb@semihalf.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for writing debug logs to trace events and trace instances.
The rationale behing this feature is to be able to redirect debug logs
(per each callsite individually) to trace to aid in debugging. The debug
logs output to trace can be enabled with T flag. Additionally the T flag
accepts trace destination which can be provided to the T flag after ":".
The trace destination field is used to determine where debug logs will be
written. 

In order to redirect callsite debug log to a trace instance it has to be
initialized first with a newly introduced "open" command. For example,
"usb" trace instance in <debugfs>/tracing/instances/ can be initialized
by issuing the command:

localhost ~ # echo "open usb" >
                                <debugfs>/dynamic_debug/control

If the trace instance <debugfs>/tracing/instances/usb already exists
then it will be reused otherwise new usbcore instance will be created.
Maximum 63 trace instances can be "opened". The trace instance name can
include any of ^\w+ and underscore characters. There is also a special
name "0" reserved for writing debug logs to trace prdbg and devdbg events.
The reserved name "0" does not require to be "opened" before use.

To enable writing usbcore module debug logs to the "usb" trace instance
opened above a user can issue the command:

localhost ~ # echo "module usbcore =pT:usb" >
                                <debugfs>/dynamic_debug/control

Please note that output of debug logs to syslog (p flag) and trace (T flag)
can be independently enabled/disabled for each callsite. Therefore the
above command will enable writing of debug logs not only to the trace
instance "usb" but also to syslog.

When trace destination is followed by another flag the next flag has to
be preeceded with ",", for example

localhost ~ # echo "module usbcore =pT:usb,l" > 
                                <debugfs>/dynamic_debug/control

To simplify processing trace destination can be omitted when default
trace destination is set, for example the command

localhost ~ # echo "module usbcore =pTl" >   
                                <debugfs>/dynamic_debug/control

will use default trace destination. If default trace destination is not
set the above command will fail. The default trace destination is set
when a command with any of the flags [-+=] and explicitly provided trace
destination matches at least one callsite, for example the command

localhost ~ # echo "module usbcore -T:usb" >   
                                <debugfs>/dynamic_debug/control

will disable trace for all usbcore module callsites (if any was enabled)
and will set "usb" instance as default trace destination. To enable writing
thunderbolt module debug logs to the "usb" trace instance as well a user
can issue the command:
  
localhost ~ # echo "module thunderbolt =T" >    
                                <debugfs>/dynamic_debug/control

Since default trace destination was previously set therefore "usb" instance
name does not have to be explicitly provided.

When no callsite writes debug logs to a trace instance then it can be
released (its reference counter decrased) with the "close" command. 
Closing a trace instance make it unavailable for dynamic debug and also
allows a user to delete such a trace instance at convenient time later
with rmdir command. For example when "usb" instance is not used anymore
a user can issue the command:

localhost ~ # echo "close usb" >
                                <debugfs>/dynamic_debug/control 
and then to delete it with:

localhost ~ # rmdir <debugfs>/tracing/instances/

To enable writing usbcore module debug logs to trace dyndbg:prdbg and
dyndbg:devdbg events user can issue the command:

localhost ~ # echo "module usbcore =T:0" >
                                <debugfs>/dynamic_debug/control
 
Then dyndbg trace events can be for example captured with the command:

localhost ~ # trace-cmd start -e dyndbg 

And displayed with the command:

localhost ~ # trace-cmd show



TODOs:
- update dynamic debug documentation,
- create test harness for the verification of dynamic debug
functionality ???,



There is one checkpatch error left:

ERROR: need consistent spacing around '*' (ctx:WxV)
140: FILE: lib/dynamic_debug.c:1070:
+				  va_list *args)

Which seems to be a false positive to me.



Changes:
V2->V1
Major rework after receiving feedback in
https://lore.kernel.org/all/20231103131011.1316396-1-lb@semihalf.com/

This includes among other things:
- addition of open/close commands,
- use names instead of numbers for trace destinations,
- change prdbg and devdbg trace events to strip newline
on the slow path side (read side),
- change prdbg and devdbg trace events to stores actual values
instead of pointers because if a pointer becomes invalid then
the TP_printk call will cause a crash,
- add support for default trace destination. 

V1 
Major rework after receiving feedback in 
https://lore.kernel.org/all/20230915154856.1896062-1-lb@semihalf.com/

Jim Cromie (7):
  dyndbg: add _DPRINTK_FLAGS_ENABLED
  dyndbg: add _DPRINTK_FLAGS_TRACE
  dyndbg: add write events to tracefs code
  dyndbg: add 2 trace-events: prdbg, devdbg
  tracefs: add __get_str_strip_nl - RFC
  dyndbg: use __get_str_strip_nl in prdbg and devdbg
  dyndbg: repack _ddebug structure

Łukasz Bartosik (8):
  dyndbg: move flags field to a new structure
  dyndbg: add trace destination field to _ddebug
  dyndbg: add open and close commands for trace
  dyndbg: don't close trace instance when in use
  dyndbg: add processing of T(race) flag argument
  dyndbg: add support for default trace destination
  dyndbg: write debug logs to trace instance
  dyndbg: add support for hex_dump output to trace

 .../admin-guide/dynamic-debug-howto.rst       |   5 +-
 MAINTAINERS                                   |   1 +
 include/linux/dynamic_debug.h                 |  59 +-
 include/trace/events/dyndbg.h                 |  54 ++
 include/trace/stages/stage3_trace_output.h    |   9 +
 lib/Kconfig.debug                             |   1 +
 lib/dynamic_debug.c                           | 688 ++++++++++++++++--
 7 files changed, 735 insertions(+), 82 deletions(-)
 create mode 100644 include/trace/events/dyndbg.h

-- 
2.43.0.rc2.451.g8631bc7472-goog

