Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D866878F6DA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 03:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348095AbjIABvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 21:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348088AbjIABu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 21:50:59 -0400
Received: from sonic307-8.consmr.mail.gq1.yahoo.com (sonic307-8.consmr.mail.gq1.yahoo.com [98.137.64.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E6DE70
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 18:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1693533053; bh=fs6edp0Ql9dxe2UkRLiHciaEhPbe6s3IRV3VEcW9sCk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=fUpYZ6H8tzzP5PATU9v4wmIfiDnaZCRidIWPgepEA87XWR0QkpCUx08uBDDQGu3hx56LWZW+bChqrGCED4VpjzuFxR/5AdSvPqMhH5dgUhBZMlTW4zGb+gJD29w96EeIb/OcfPlI0yrOV1PVcw6urjdclYsdf2CLLEpDF9RfZD2254qgdVJDnD4KK9RRkxuiUGXH7Lo49nG+ABw1MbmcrSVr0dimjx157BsopJfqAvVoumY9VRiQQEc4zhkYIC1zs+K+J1+RFG5lfO2pLplNXhJHPZWSBAa9ZL580ztMGGT8qZJkJJEGUwKDhiVF9O2jwZuIGh6JNYx78IGcf61pSg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693533053; bh=VLb0dD9PUbC6ExKTFE1w5tQN3z+T3xQkDGIZ7Lbxxc/=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=P2qjXG6gWd86TVsRMsRVq1W/VnfzhZD3IdWnn5eVd9RslLEQKtD5gRkzuZ0pUi3qtv65LiHCph0q+ZYrg+hrwo/ILcs7wwmt7WHv9IR3Yo4H04fPKdrkjXd6fhbFRWevr0XkPZccHadE+VcdbPS+PlSVBapnThzb3iXTjmd+SxKMSrHX2L/W9ScK7YTB+RMvuE5PbG1iowwl94QzvmtnUoFITx64FqbkaPQVRVcSyK7IXCvXCho3/JiTLAXXR55SmbP9ILetQ7w2hyITT95HNaS7cjPp6lW7CYQFjhLn4/99qKkCjmmEZhOWJ9VQEGqVDZ4FYLit9nFLL7667k/Law==
X-YMail-OSG: 2UhxypAVM1mOfz0zB8YBWTOSMq3VqqQ_9J1tXZUVnNvwuitVIPKxdlJSr57EuNp
 cwRsrL9bEbVcdGZdKOw376vwrDmSLgy5wIBpJhKAcuicbv61GrZ7qQtMYNi7EZs0oe1h0MX9IsNS
 W4Td5Bg6Nm3NTKKtZdaZ.ycOR20ia_8nlTu___41IMXJlibVhCUHCvRKhLCG6cIEkC9.5hJJG4Gu
 3rlDc3cRxjN9dz1i0pXE39mUiulRJfSoeJDLe.i0C_0hPy7xuQxq6zfNWha9KfXZqnf.SHzOpJWu
 1qNuRDIp3qLr1nbIgImEEZVV8jQS7XATvjZZKovtBY2Rx5Ft3WtRzMfkcEhIqPCXS7IS3_mh2VCk
 cCodLVkN00d1RPjE_tDJfwBxNpIJr4aK70Ki0LWvv3gVNdEVlJvu.eQEeKcik2GlaN.gFXdF4_oi
 I4icZomovk3X3yN8Og_VTUvyRvRqS4tdyqoR9xuJekcz_c_vgHrmQAQisd8KaNtRYzxewJIEDARE
 m3_m2XFM1u_CDtLvJroYbO6tkoTM_aWL66lTHZ6vYAc6BG_yoUqgM6YZV3OWhXZU84dA8NbD5pdO
 Yp24nEueAoyhe5Yru6wvMKQ2RNZunZ5KT.OXD8YnTVSTTbbLrsLS2fwgFrlTXWGeO.o3T1jBAOqW
 hKp4D3fx05oNiEwoJDOaPzfExzVbkNL31QzdCpXhazBI4ZmITuDzYuMkGLbhARbnhBgXrTVpkjj4
 rM2lJHdhLqi2upSCtLWkTEMcPBVWvkZffcp_R0JtM7vDhiMzopv0l2dJbACxHSENmsALM6yp8hKX
 PAWibOcjeoip8YujxMmwX.ZCRn_tDya_MBCCHVfSf2eoVQB03cZf1AjlCs00Lz7ZNLdsu5uiBGN2
 B2k5QM5v4NZwxqxcrts9tJXI9kifd5ZbQit_fSiUUZjO90fcX2KrOnYnK2Dp8WWEHTuu7PG5hguP
 3FdVmbUQFdb9vcmATWfnh4S03MH1ChJANF7m0fO558c.sJ6FSlOLHJSqMqr1rfyYYap9xfrzlrF1
 WJgd9s1lCbsSbHe60GphbHfFpSpSAuKFjOdnK6d92Z56FZGFqc4_YxKZVbntrbXJiEerWwQ1X9E7
 lMMdBtttIkhb8dNpF5NmcVTKstcBxUG7sotkv_RwVef_i7pbGE4PtulyXY7O7hpOl.pXINt_qDw7
 rxV1dp0ZFy9gKKqOQZpwF3to8VsRtwz14r1kzcQoqtg8LsvNjTosWl.fv6B12Xbk9jvqNMgnfDx8
 wsf2FBQqGxISh36YyoFrxInffc5NubqguWQnuqe1q.7.qKd.uZM3mXA6NJL4PfF24l3kdsr7mZoS
 QnH9ji2h5Hi3.ct5dvxHtDi5rmxHGhcNnvKHG8Pvk35yJzmB8OQGZnu.4Sa5ZuR.G4GCsqQsEJD1
 l962Ow8bKzN3krHzxvrbg1qDbITxmaCTSNCHdjeHvjT2d7KoeFIajzE8IOROc1QAwvY0PwSS40uj
 5u.efKQ0WWG2qFkYh1ZtWVuq04JPMASTS2KFvZrUfxsKkwCKLsrcV0L.IC09sTHxxv1VvmfytJb6
 PX9MbbQ6TLfq9qv2ZXToDIkdTZXuyKJGTu7HTpgu_uS0SkqNs34jdz7rx0Q95KYKeUdFh56uIARN
 aZgMnNztbt7A5GieE8WL2pCzNqYpNXNP5.34lkJiiQOlq42SS9YQI0fC259nWoIeNTYmUBVuE4IN
 q9rijJDqbCG4ZXlnoCysGjnoP3i3xFZnosXwP416dQmSsXRVZZKzK84hYTdzF4keEOJQe3DbTc9C
 SrlEconE6vAMUWYOHuMhQNbKVYfKmYO_FdQgxkzFFnRAKMl11tnERRjeNNyQb56j35DUDQLk3cqJ
 ofbDMNH094m4gt5BpABqg_342Qca0ANkSwS.dvYf1U4DskQxlU5zTenlkpdilfnE8sZXGc.MvBRq
 syo7TqF.mFmrgHJ6KuWR9YznFDvXwhb0mRzjHCqjgM3WFXLZHq48KdpJigTM6iDbeojGZTkbLn.Q
 WlmrsclFpyqFFDy9Lp_xYVvEuAhcI4mfnS4OdTlg03O9JTF1M6X8nB70R59ugvq73vR5Q6y7.y9C
 DVuWPV0zlhct3bMYpkV4IiSa6SZTnopHuSKB.WLO_hNqzKO8hmnzTlUqIU41ES7lsVlI6qAgbLHL
 ysCv_qfxslK1pxmiDinKxPFZ2CxxBvStcIwoO6bLFbABwwpVTFiN4rmFSJ0p_Ge.d.qQs.nbF.5q
 ZKiMs5JONMsjYuhNFFETrm1cKsMlumLOci9fs_DYFz_Stp73l.TDnsvs76IIG2mit2GobW70U31A
 Qyxwl14ok
X-Sonic-MF: <earl.chew@yahoo.ca>
X-Sonic-ID: 025e5646-6e0d-4d8f-a8a7-659d812a72ad
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.gq1.yahoo.com with HTTP; Fri, 1 Sep 2023 01:50:53 +0000
Received: by hermes--production-ne1-7b767b77cc-84nnk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 10ad77be201d39a9d7996c67b7a2e3e0;
          Fri, 01 Sep 2023 01:50:48 +0000 (UTC)
Received: from localhost.lan ([127.0.0.1]:51082 helo=localhost.localdomain)
        by postbox.timberdragon.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95.0)
        (envelope-from <earl.chew@yahoo.ca>)
        id 1qbtJ8-000Ozs-PG;
        Thu, 31 Aug 2023 18:50:46 -0700
From:   Earl Chew <earl.chew@yahoo.ca>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     peter@hurleysoftware.com, earl.chew@yahoo.ca
Subject: [PATCH 0/3] tty: Fix tiocspgrp() related races
Date:   Thu, 31 Aug 2023 18:50:28 -0700
Message-Id: <20230901015030.2469062-1-earl.chew@yahoo.ca>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230831143645.2298799-1-earl_chew@yahoo.com>
References: <20230831143645.2298799-1-earl_chew@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Reposting to linux-kernel@vger.kernel.org ]

This set of patches improves tiocspgrp() use cases, and was
motivated by noticing rare job control SIGTTIN/SIGTTOU races.
Over time, users probably have encountered these races during
interactive use, but quite possibly have simply worked through
them.

The first patch addresses a race that occurs when a job control
shell runs a fg command to move a background job to the foreground.
The shell issues tcsetpgrp() followed by killpg(SIGCONT). In
rare cases this coincides with the new foreground job receiving
a SIGTTIN which gives the appearance that fg stops the job.
The first reproducer below can detect this case:

    while ./first ; do : ; done
    WIFSTOPPED 21

The second patch addresses a race that occurs when a job
control application issues several tcsetpgrp() calls in
parallel. In rare cases, the callers will only partially serialise.
After the first successfully sets the foreground process group,
the remaining should receive SIGTTOU because they are now
background processes that are attempting to change the
foreground process group. Instead, they successfully reconfigure
the foreground process group of the controlling terminal.
The second reproducer below can detect this case:

    while ./second ; do : ; done
    Died at line 86: Exited 2 Stopped 0

The third patch relocates the sampling of task_pgrp() in
__tty_check_change_locked() to place it inside the locked
region, immediately before the value is used. This improves
the consistency of the sampled value, and follows the example
set by __proc_set_tty().

/* FIRST RACE */
    #include <errno.h>
    #include <fcntl.h>
    #include <stdarg.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <signal.h>
    #include <time.h>
    #include <unistd.h>

    #include <sys/wait.h>

    #define DIE(...) die(__LINE__, __VA_ARGS__)

    void die(unsigned lineno, const char *fmt, ...)
    {
        va_list argp;

        va_start(argp, fmt);
        vfprintf(stderr, fmt, argp);
        fputc('\n', stderr);
        exit(1);
    }

    void delay(unsigned range, unsigned scale)
    {
        unsigned rnd = random() % range;

        struct timespec delay = {
            .tv_nsec = rnd * scale
        };

        nanosleep(&delay, 0);
    }

    int main()
    {
        const char *ttyname = ctermid(0);
        if (!ttyname) DIE("ctermid");

        int ttyfd = open(ttyname, O_RDONLY | O_NONBLOCK);
        if (-1 == ttyfd) DIE(ttyname);

        typedef void (*sighandler_t)(int);

        sighandler_t sighandler = signal(SIGINT, SIG_DFL);
        if (SIG_ERR == sighandler) DIE("signal");

        sigset_t sigmask;
        if (sigprocmask(SIG_SETMASK, 0, &sigmask)) DIE("sigprocmask");
        if (sigismember(&sigmask, SIGTTIN)) DIE("SIGTTIN");

        pid_t child = fork();

        if (!child) {

            srandom(getpid());

            if (setpgid(0, 0)) DIE("setpgid");

            delay(10000, 1);

            char buf[1];
            int rd = read(ttyfd, buf, 0);
            if (rd) DIE("read");

        } else {

            srandom(getpid());

            if (setpgid(child, child)) DIE("setpgid");

            delay(10000, 1);

            if (tcsetpgrp(ttyfd, child)) DIE("tcsetpgrp");

            if (killpg(child, SIGCONT)) DIE("killpg");

            int status;
            pid_t waited = waitpid(child, &status, WUNTRACED);
            if (child != waited) DIE("waitpid");

            kill(child, SIGKILL);

            if (WIFSTOPPED(status)) DIE("WIFSTOPPED %d", WSTOPSIG(status));
            if (!WIFEXITED(status)) DIE("WEXITED");
            if (WEXITSTATUS(status)) DIE("WEXITSTATUS");
        }

        return 0;
    }
/* FIRST RACE */

/* SECOND RACE */
    #include <errno.h>
    #include <fcntl.h>
    #include <stdarg.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <signal.h>
    #include <unistd.h>

    #include <sys/wait.h>

    #define DIE(...) die(__LINE__, __VA_ARGS__)

    void die(unsigned lineno, const char *fmt, ...)
    {
        va_list argp;

        fprintf(stderr, "Died at line %u", lineno);
        if (fmt) {
            fprintf(stderr, ": ");
            va_start(argp, fmt);
            vfprintf(stderr, fmt, argp);
        }
        fputc('\n', stderr);
        exit(1);
    }

    int main()
    {
        const char *ttyname = ctermid(0);
        if (!ttyname) DIE(0);

        int ttyfd = open(ttyname, O_RDONLY | O_NONBLOCK);
        if (-1 == ttyfd) DIE(ttyname);

        sigset_t sigmask;
        if (sigprocmask(SIG_SETMASK, 0, &sigmask)) DIE(0);
        if (sigismember(&sigmask, SIGTTOU)) DIE(0);

        pid_t parentPid = getpid();
        pid_t pgid[2] = { };
        pid_t child[2] = { };

        for (int ix = 0; ix < 2; ++ix) {
            pgid[ix] = fork();
            if (!pgid[ix]) {
                if (setpgid(0, 0)) DIE(0);
                exit(0);
            }
            if (setpgid(pgid[ix], pgid[ix])) DIE(0);

            child[ix] = fork();
            if (!child[ix]) {
                if (kill(getpid(), SIGSTOP)) DIE(0);
                printf("Child %d foreground %d\n", getpid(), pgid[ix]);
                if (tcsetpgrp(ttyfd, pgid[ix])) DIE(0);
                exit(0);
            }

            if (-1 == child[ix]) DIE(0);
            if (child[ix] != waitpid(child[ix], 0, WUNTRACED)) DIE(0);
        }

        if (SIG_ERR == signal(SIGTTOU, SIG_IGN)) DIE(0);
        if (kill(-parentPid, SIGCONT)) DIE(0);

        int status;
        int stopped = 0;
        int exited = 0;

        for (int ix = 0; ix < 2; ++ix) {
            pid_t waited = waitpid(child[ix], &status, WUNTRACED);
            if (waited != child[ix]) DIE("Child %d", child[ix]);

            if (WIFEXITED(status))
                ++exited;
            if (WIFSTOPPED(status))
                ++stopped;
        }

        for (int ix = 0; ix < 2; ++ix) {
            if (kill(pgid[ix], SIGKILL) && ESRCH != errno) DIE(0);
            if (kill(child[ix], SIGKILL) && ESRCH != errno) DIE(0);
        }

        if (2 == exited)
            DIE("Exited %d Stopped %d", exited, stopped);

        return 0;
    }
/* SECOND RACE */

Earl Chew (3):
  tty: Fix __tty_check_change() and tiocspgrp() race
  tty: Serialise racing tiocspgrp() callers
  tty: Move task_pgrp() after tty->ctrl.lock for consistency

 drivers/tty/tty_jobctrl.c | 44 ++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 12 deletions(-)

-- 
2.39.1
