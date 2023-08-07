Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29D6771930
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 06:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjHGE40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 00:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHGE4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 00:56:23 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CDF10FA;
        Sun,  6 Aug 2023 21:56:21 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-63d0bf91362so17494846d6.0;
        Sun, 06 Aug 2023 21:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691384181; x=1691988981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oi3EV0tOoJkjoxq1L5OBiiCYkYCKXXR7N7CE/jB6lMQ=;
        b=aaPu78AYKLluiayVqsvQznBXCLA88N5XZchOdyG0munM/Bwzc1DZ4QUHl24h3YnTRG
         ILwCTFpoeRCY2X0K6pLdAPWJgwWnqnUUIt/Yyqvm/Zx5oS01t35tWdPxd5xL5y21/OBp
         axvOvfv3J+VsmWDAfs2sHgsHtj+zZRF6/hZUHl2ftBBRtMhR1HMYWnpcTDyNL8DvN9u9
         4TxjY6SVf6yuSsPxTNUfYdxM/1FKpKu+4WQWM7c0XDlTtw0BcWZE4V8CYmz6Rv5QXMsB
         dLUuic9x8tzAZRsCLTV/h9Wurq4dRPlDk9XUIkIGa+2pSkZv3NiJbpjnBPQipMAiEbqU
         1ToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691384181; x=1691988981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oi3EV0tOoJkjoxq1L5OBiiCYkYCKXXR7N7CE/jB6lMQ=;
        b=bwLo0N+jZ4DKYMGPOav7Oo7zXjZOE4hMhrNLswaCOfhPgJMVhibnQEvZApLWB+pj0H
         QqSHAZ6bWM+frNt3CBDA5aUFUHm6X4ClHeO8CSYdFqHZ9KOaBwvPVCdu6KNY8ojRQj4N
         okW5KtfmMz99W+2qxYnKicxtINhwO8u0It66wiwneV5ZTApFHEfgldXVR8tpmVqXYnlI
         I5g1AV1zpc2T5ARpfsrItRMtmCNBT8+8iENULjUozdWW9BjY0hEPLHdf3/X6s5V/Arq0
         YH59pUiti0F5Usr7CxPeDHBbQuMnP2Uai+jjl1sT8/GqdyOKPtisumvjUHZJZlC9fC8r
         AojQ==
X-Gm-Message-State: AOJu0YxyhpsevYgz1v/cUNaHV+6ms8O5tSJryc5Lf3MUstjhmiI9zwjK
        uAUw44ldCamVYrNs4mkYHDw=
X-Google-Smtp-Source: AGHT+IGY48TmFz+ohOAJ9icghf4UxtHTiG+Y8huxdeyR67+5z7+tSThWXRzFg1wOdi4f8/OakE0RJA==
X-Received: by 2002:a0c:f18b:0:b0:63c:ec39:13d0 with SMTP id m11-20020a0cf18b000000b0063cec3913d0mr4750467qvl.64.1691384180834;
        Sun, 06 Aug 2023 21:56:20 -0700 (PDT)
Received: from localhost.localdomain ([191.96.150.37])
        by smtp.gmail.com with ESMTPSA id v14-20020a0cdd8e000000b0063d366b0300sm2590313qvk.89.2023.08.06.21.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 21:56:20 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        torvalds@linux-foundation.org, randy.dunlap@oracle.com,
        paulmck@kernel.org, corbet@lwn.net, markus.heiser@darmarIT.de
Subject: [PATCH]upi:media: Added rest of the Generic Error Codes to the existing list
Date:   Mon,  7 Aug 2023 10:03:16 +0530
Message-ID: <20230807045212.32489-2-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added rest of the Generic Error Codes to the existing list of codes.

cc: torvalds@linux-foundation.org
cc: randy.dunlap@oracle.com
cc: paulmck@kernel.org
cc: corbet@lwn.net
cc: markus.heiser@darmarIT.de

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 There is a "moreutils" package across the Linux distribution, if you
 installed it and that package has a binary name "errno",if you run it with
 "-l" or "--list" option, it will show all the error codes.In my system, while
 running it shows me precisely, 134 of such codes.YMMV

 .../userspace-api/media/gen-errors.rst        | 479 ++++++++++++++++++
 1 file changed, 479 insertions(+)

diff --git a/Documentation/userspace-api/media/gen-errors.rst b/Documentation/userspace-api/media/gen-errors.rst
index e595d0bea109..2d5dd8f7faea 100644
--- a/Documentation/userspace-api/media/gen-errors.rst
+++ b/Documentation/userspace-api/media/gen-errors.rst
@@ -85,6 +85,485 @@ Generic Error Codes
        -  No device corresponding to this device special file exists.


+    -  - ``ENOENT``
+
+       -  No such file or directory.
+
+    -  - ``ESRCH``
+
+       -  No such process.
+
+    -  - ``EIO``
+
+       -  Input/output error.
+
+    -  - ``E2BIG``
+
+       -  Argument list too long.
+
+    -  - ``ENOEXEC``
+
+       -  Exec format error.
+
+    -  - ``ECHILD``
+
+       -  No child processes.
+
+    -  - ``EACCES``
+
+       -  Permission denied.
+
+    -  - ``ENOTBLK``
+
+       -  Block device required.
+
+    -  - ``EEXIST``
+
+       -  File Exists.
+
+    -  - ``EXDEV``
+
+       -  Invalid cross device link.
+
+    -  - ``ENOTDIR``
+
+       -  Not a directory.
+
+    -  - ``EISDIR``
+
+       -  Is a directory.
+
+    -  - ``ENFILE``
+
+       -  Too many open files in system.
+
+    -  - ``EMFILE``
+
+       -  Too many open files.
+
+    -  - ``ETXTBSY``
+
+       -  Text file busy.
+
+    -  - ``EFBIG``
+
+       -  File too large.
+
+    -  - ``ESPIPE``
+
+       -  Illegal seek.
+
+    -  - ``EROFS``
+
+       -  Read-only file system.
+
+    -  - ``EMLINK``
+
+       -  Too many links.
+
+    -  - ``EPIPE``
+
+       -  Broken pipe.
+
+    -  - ``EDOM``
+
+       -  Numerical argument out of domain.
+
+    -  - ``ERANGE``
+
+       -  Numerical result out of range.
+
+    -  - ``EDEADLK``
+
+       -  Resourse deadlock avoided.
+
+    -  - ``ENAMETOOLONG``
+
+       -  File name too long.
+
+    -  - ``ENOLCK``
+
+       -  No locks available.
+
+    -  - ``ENOSYS``
+
+       -  Function not implemented.
+
+    -  - ``ENOTEMPTY``
+
+       -  Directory not empty.
+
+    -  - ``ELOOP``
+
+       -  Too many levels of symbolic links.
+
+    -  - ``ENOMSG``
+
+       -  No message of desired type.
+
+    -  - ``EIDRM``
+
+       -  Identifier removed.
+
+    -  - ``ECHRNG``
+
+       -  Channel number out of range.
+
+    -  - ``EL2NSYNC``
+
+       -  Level 2 not syncronized.
+
+    -  - ``EL3HLT``
+
+       -  Level 3 halted.
+
+    -  - ``EL3RST``
+
+       -  Level 3 reset.
+
+    -  - ``ELNRNG``
+
+       -  Link number out of range.
+
+    -  - ``EUNATCH``
+
+       -  Protocol driver not attached.
+
+    -  - ``ENOCSI``
+
+       -  No CSI structure available.
+
+    -  - ``EL2HLT``
+
+       -  Level 2 halted.
+
+    -  - ``EBADE``
+
+       -  Invalid exchnage.
+
+    -  - ``EBDR``
+
+       -  Invalid request descriptor.
+
+    -  - ``EXFULL``
+
+       -  Exchange full.
+
+    -  - ``ENOANO``
+
+       -  No anode.
+
+    -  - ``EBADRQC``
+
+       -  Invalid request code.
+
+    -  - ``EBADSLT``
+
+       -  Invalid slot.
+
+    -  - ``EBFONT``
+
+       -  Bad font file format.
+
+    -  - ``ENOSTR``
+
+       -  Device not a stream.
+
+    -  - ``ENODATA``
+
+       -  No data available.
+
+    -  - ``ETIME``
+
+       -  Time expired.
+
+    -  - ``ENOSR``
+
+       -  Out of stream resources.
+
+    -  - ``ENONET``
+
+       -  Machine is not on the network.
+
+    -  - ``ENOPKG``
+
+       -  Package not installed.
+
+    -  - ``EREMOTE``
+
+       -  Object is remote.
+
+    -  - ``ENOLINK``
+
+       -  Link has been severed.
+
+    -  - ``EADV``
+
+       -  Advertise error.
+
+    -  - ``ESRMNT``
+
+       -  Srmount error.
+
+    -  - ``ECOMM``
+
+       -  Communication error on send.
+
+    -  - ``EPROTO``
+
+       -  Protocol error.
+
+    -  - ``EMULTIHOP``
+
+       -  Multihop attempted.
+
+    -  - ``EDOTDOT``
+
+       -  RFS specific error.
+
+    -  - ``EBADMSG``
+
+       -  Bad message.
+
+    -  - ``EOVERFLOW``
+
+       -  Value too large for defined data type.
+
+    -  - ``ENOTUNIQ``
+
+       -  Name not uniq on network.
+
+    -  - ``EBADFD``
+
+       -  File descriptor in bad state.
+
+    -  - ``EREMCHG``
+
+       -  Remote address changed.
+
+    -  - ``ELIBACC``
+
+       -  Can not access a needed shared library.
+
+    -  - ``ELIBBAD``
+
+       -  Accessing a corrupted shared library.
+
+    -  - ``ELIBSCN``
+
+       -  .lib section in a.out corrupted.
+
+    -  - ``ELIBMAX``
+
+       -  Attempting to link in too many shared libraries.
+
+    -  - ``ELIBEXEC``
+
+       -  Can not exec a shared library directly.
+
+    -  - ``ELIBSEQ``
+
+       -  Invalid or incomplete multibyte or wide character.
+
+    -  - ``ERESTART``
+
+       -  Interrupted system call should be restarted.
+
+    -  - ``ESTRPIPE``
+
+       -  Stream pipe error.
+
+    -  - ``EUSERS``
+
+       -  Too many users.
+
+    -  - ``ENOTSOCK``
+
+       -  Socker operation on non-socket.
+
+    -  - ``EDESTADDREQ``
+
+       -  Destination address required.
+
+    -  - ``EMSGSIZE``
+
+       -  Message too long.
+
+    -  - ``EPROTOTYPE``
+
+       -  protocol wrong type for socket.
+
+    -  - ``ENOPROTOOPT``
+
+       -  Protocol not available.
+
+    -  - ``EPROTNOSUPPORT``
+
+       -  Protocol not supported.
+
+    -  - ``ESOCKTNOSUPPORT``
+
+       -  Socket type not supported.
+
+    -  - ``EOPNOTSUPP``
+
+       -  Operation not supported.
+
+    -  - ``EPFNOSUPPORT``
+
+       -  Protocol family not supported.
+
+    -  - ``EAFNOSUPPORT``
+
+       -  Address family not supported by protocol.
+
+    -  - ``EADDRINUSE``
+
+       -  Address already in use.
+
+    -  - ``EADDRNOTAVAIL``
+
+       -  Cannot assign requested address.
+
+    -  - ``ENETDOWN``
+
+       -  Network is down.
+
+    -  - ``ENETUNREACH``
+
+       -  Network is unreachable.
+
+    -  - ``ENETRESET``
+
+       -  Network dropped connection on reset.
+
+    -  - ``ECONNABORTED``
+
+       -  Software caused connection abort.
+
+    -  - ``ECONNRESET``
+
+       -  Connection reset by peer.
+
+    -  - ``ENOBUFS``
+
+       -  No buffer space available.
+
+    -  - ``EISCONN``
+
+       -   Transport endpoint is already connected.
+
+    -  - ``ENOTCONN``
+
+       -  Transport endpoint is not connected.
+
+    -  - ``ESHUTDOWN``
+
+       -  Cannot send after transport endpoint shutdown.
+
+    -  - ``ETOOMANYREFS``
+
+       -   Too many references: cannot splice.
+
+    -  - ``ETIMEDOUT``
+
+       -  Connection timed out.
+
+    -  - ``ECONNREFUSED``
+
+       -  Connection refused.
+
+    -  - ``EHOSTDOWN``
+
+       -  Host is down.
+
+    -  - ``EHOSTUNREACH``
+
+       -  No route to host.
+
+    -  - ``EALREADY``
+
+       -  Operation already in progress.
+
+    -  - ``EINPROGRESS``
+
+       -  Operation now in progress.
+
+    -  - ``ESTALE``
+
+       -  Stale file handle.
+
+    -  - ``EUCLEAN``
+
+       -  Structure needs cleaning.
+
+    -  - ``ENOTNAM``
+
+       -   Not a XENIX named type file.
+
+    -  - ``ENAVAIL``
+
+       -   No XENIX semaphores available.
+
+    -  - ``EISNAM``
+
+       -  Is a named type file.
+
+    -  - ``EREMOTEIO``
+
+       -  Remote I/O error.
+
+    -  - ``EDQUOT``
+
+       -  Disk quota exceeded.
+
+    -  - ``ENOMEDIUM``
+
+       -  No medium found.
+
+    -  - ``EMEDIUMTYPE``
+
+       -  Wrong medium type.
+
+    -  - ``ECANCELED``
+
+       -  Operation canceled.
+
+    -  - ``ENOKEY``
+
+       -  Required key not available.
+
+    -  - ``EKEYEXPIRED``
+
+       -   Key has expired.
+
+    -  - ``EKEYREVOKED``
+
+       -  Key has been revoked.
+
+    -  - ``EKEYREJECTED``
+
+       -  Key was rejected by service.
+
+    -  - ``EOWNERDEAD``
+
+       -   Owner died.
+
+    -  - ``ENOTRECOVERABLE``
+
+       -  State not recoverable.
+
+    -  - ``ERFKILL``
+
+       -   Operation not possible due to RF-kill.
+
+    -  - ``EHWPOISON``
+
+       -  Memory page has hardware error.
+
+    -  - ``ENOTSUP``
+
+       -  Operation not supported.
 .. note::

   #. This list is not exhaustive; ioctls may return other error codes.
--
2.41.0

