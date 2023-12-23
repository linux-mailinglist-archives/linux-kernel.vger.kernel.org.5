Return-Path: <linux-kernel+bounces-10160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ABC81D0FC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31176285033
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EACFECB;
	Sat, 23 Dec 2023 01:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="R/AsfkB3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEABE7EE
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-336788cb261so1904627f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703296310; x=1703901110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j47JecJQSReok5EE7EHief9slHGR44n5jv9vlX7OhJo=;
        b=R/AsfkB31zdr6BVjzP0K5G/vMzyj6wE16nSftWbzAFfCvK8g6SQxJ3jW/D1+xfi2F2
         fwv5ETvXkYgs0/5nDmUIsP9Oc83tCeJ8n0i3pF4yAoG32FHqvoXLRSUDOVb1WZ9yBSvP
         OSWHbMu0zr1vof6eqs+isuyHtRv5ZGdIoYWSPteZ94UFLP+MlstH9mf6mfLhGOJGFeFe
         1Pgj3G09bFRn007NyEnjaJj7PrRbKOxwcrDd7TdJfYGiwMFqmJfGb3IQMgyA3C+MAMVN
         Vt+F9Nhfk1GXLVxQgmpVH9asASWZUtP9Uj0ORB1VgmalgPZ9OqKfVAiCg1J7DErwZmrv
         ZmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296310; x=1703901110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j47JecJQSReok5EE7EHief9slHGR44n5jv9vlX7OhJo=;
        b=NrF+zSzkuMtM0aTCoRg9bts8kP1iRTvZDWbbNsD3hliu5v1VdiN5F/7Oagt9s+D7PZ
         ePZLj692Xh3yYPRNelN+C7pYenVgcSgcFTG4jVdI5KNex6L68+fNcF06C9eVZjTTyk/L
         Da3qUJBVB18F+bpGv1zWPZ8sMviE/w3thKg8Ux4wJXUnngU2P0NQYM9URhPbsAA2z61I
         NFENqh/QuJc3y4BBABo5Z9pVz4+Gx1VgMH/5HgnlmsZISb7AJUZ63YEeqXofvYuSPLq+
         zHs4dehm//Nqr2sGo3urmNeuANVPFAcGxh7qAcssu9jQyjDCwh1si0LxdOlx3P/rS22o
         6Ujg==
X-Gm-Message-State: AOJu0YycMYSDirl8fKO5CHrhpoWR8pta8f7ZMMkcVEHpwAjyUnBcITkI
	mB/yCyOrK59nSDUOmlnwC24wfWRNcQNZ
X-Google-Smtp-Source: AGHT+IFSzG5lzhddDr21TBuZ7EsGhGI20MPltRqlaSx4jS4a7taWHQLr30RSukNdXwOoaYUCzfCDDg==
X-Received: by 2002:a5d:4c8d:0:b0:336:81d8:3ed0 with SMTP id z13-20020a5d4c8d000000b0033681d83ed0mr1264332wrs.26.1703296309614;
        Fri, 22 Dec 2023 17:51:49 -0800 (PST)
Received: from ukaszb-l.semihalf.net (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005532a337d51sm3288494eda.44.2023.12.22.17.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:51:49 -0800 (PST)
From: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <lb@semihalf.com>
To: Jason Baron <jbaron@akamai.com>,
	Jim Cromie <jim.cromie@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Guenter Roeck <groeck@google.com>,
	Yaniv Tzoreff <yanivt@google.com>,
	Benson Leung <bleung@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	Sean Paul <seanpaul@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Simon Ser <contact@emersion.fr>,
	John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	linux-kernel@vger.kernel.org,
	upstream@semihalf.com
Subject: [PATCH v3 00/22] dyndbg: add support for writing debug logs to trace
Date: Sat, 23 Dec 2023 02:51:09 +0100
Message-ID: <20231223015131.2836090-1-lb@semihalf.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
be preeceded with ".", for example

localhost ~ # echo "module usbcore =pT:usb.l" > 
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



Jim, I made a few changes to the test script dd-selftest.rc you created
and I also added new test scenarios. You can find the entire patchset
with the test script changes on top here
https://chromium.googlesource.com/chromiumos/third_party/kernel/+log/refs/sandbox/ukaszb/dyndbg_trace_v3
I wonder where would be the proper place to store the test script
(upstream, your github.com:jimc/linux.git)
Do you have a suggestion for that ?

TODOs:
- update dynamic debug documentation,
- finalize discussion related to default trace destination
(whether we want it at all, if yes then conclude on the details)

Changes:
V3 -> V2
- squash "dyndbg: export _print_hex_dump" with "dyndbg: add support for hex_dump output to trace",
- squash "dyndbg: tweak pr_info format s/trace dest/trace_dest/"  with "dyndbg: add processing of T(race) flag argument",
- squash "dyndbg: change +T:name_terminator to dot" with "dyndbg: add processing of T(race) flag argument",
- fix setting default trace destination,
- decrease use count when callsite is being disabled as a part of module removal,
- fix parsing of T flag argument,
- update __get_str_strip_nl macro per Steve's comment,
- drop commit "dyndbg: move lock,unlock into ddebug_change, drop goto" and add comment explaining why ddebug_parse_flags
and ddebug_change have to be run in critical section,
- add "depends on TRACING" for "DYNAMIC_DEBUG",
- update DYNAMIC_DEBUG_BRANCH macro which is used when CONFIG_JUMP_LABEL is not set,
- change structure name ddebug_trace_inst to dd_private_tracebuf,
- change structure name ddebug_trace to dd_tracebuf_tbl_info,
- rename is_ddebug_cmd to is_dd_trace_cmd,
- rename validate_tr_name to dd_good_trace_name,
- rename handle_tr_opend_cmd to handle_trace_opend_cmd and handle_tr_close_cmd to handle_trace_close_cmd,
- refactor ddebug_parse_cmd,
- add pr_err when trace_array_get_by_name or trace_array_init_printk fails in trace_array_init_printk,
- add static prefix to show_T_args,
- rename TRACE_DST_MAX to TRACE_DST_LAST and change its value to 64, reserve index 0 for trace events in dd_tracebuf_tbl_info (index 0 will be wasted),
- add "#: " prefix to "Default trace destination" and "Opened trace instances" and print all opened trace instances on the same line,

V2->V1
Major rework after receiving feedback in
https://lore.kernel.org/all/20231103131011.1316396-1-lb@semihalf.com/

This includes among other things:
- addittion of open/close commands,
- use names instead of numbers for trace destinations,
- change prdbg and devdbg trace events to strip newline
on the slow path (read side),
- change prdbg and devdbg trace events to stores actual values
instead of pointers because if a pointer becomes invalid then
the TP_printk call will cause a crash,
- add support for default trace destination. 

V1 
Major rework after receiving feedback in 
https://lore.kernel.org/all/20230915154856.1896062-1-lb@semihalf.com/

Jim Cromie (14):
  dyndbg: add _DPRINTK_FLAGS_ENABLED
  dyndbg: add _DPRINTK_FLAGS_TRACE
  dyndbg: add write events to tracefs code
  dyndbg: add 2 trace-events: prdbg, devdbg
  tracefs: add __get_str_strip_nl - RFC
  dyndbg: use __get_str_strip_nl in prdbg and devdbg
  dyndbg: repack _ddebug structure
  dyndbg: disambiguate quoting in a debug msg
  dyndbg: fix old BUG_ON in >control parser
  dyndbg: treat comma as a token separator
  dyndbg: add skip_spaces_and_coma()
  dyndbg: split multi-query strings with %
  dyndbg: reduce verbose/debug clutter
  dyndbg: id the bad word in parse-flags err msg

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
 include/linux/dynamic_debug.h                 |  57 +-
 include/trace/events/dyndbg.h                 |  54 ++
 include/trace/stages/stage3_trace_output.h    |  13 +
 lib/Kconfig.debug                             |   2 +
 lib/dynamic_debug.c                           | 736 ++++++++++++++++--
 7 files changed, 775 insertions(+), 93 deletions(-)
 create mode 100644 include/trace/events/dyndbg.h

-- 
2.43.0.472.g3155946c3a-goog


