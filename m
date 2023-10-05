Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E19D7BA001
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbjJEOcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbjJEOa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:30:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FA026190
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 05:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YVnnDDlKWUOi57OobOPRCF3BfC6ap1G7lU+puoy3/y0=; b=ZvBB3fvTX9TBP+Lsj/xz8a3ura
        6c3jb0kpiI5wt0ODzBwzEsyzPKX4SH3E2comfWnyYo7zjs/35W/IPf5v+/pHm4uhM/EOE1gH/FPUF
        ivtLwBCqNHF6WloZnKrTcjhIIQxmDm55EyWf3oMJbu8DF3724J9lxfEefbnmUp29h4EOW6jGds4MN
        H8Ye2vFQb4PsjwGMWxcd3/6Qt514u7qPywMtLSo9TvUYmOhWibZE0AeIIAlUYeahU+HrowifTg+rk
        JPmNj8ponoQ9fO/NueDDJTaM6Rbjba5Q/xMcz0sEKLbei9RRhY+fsNS5KA/dmMOk/Da1tdR9gAV9k
        vw5Qz0VA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qoN78-009FYK-2M; Thu, 05 Oct 2023 12:05:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8FCD300451; Thu,  5 Oct 2023 14:05:57 +0200 (CEST)
Date:   Thu, 5 Oct 2023 14:05:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Youssef Esmat <youssefesmat@chromium.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
Subject: Re: [PATCH 00/15] sched: EEVDF and latency-nice and/or slice-attr
Message-ID: <20231005120557.GA743@noisy.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <dlbtvvm5cewqzh5bcpl4cqhcwxmnnjb6pdle5jzywiiznlactd@cmhnpim42m3p>
 <20230906131356.GG38741@noisy.programming.kicks-ass.net>
 <CA+q576MS0-MV1Oy-eecvmYpvNT3tqxD8syzrpxQ-Zk310hvRbw@mail.gmail.com>
 <20231002184136.GA1539@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HAS2VO5y3up6UKra"
Content-Disposition: inline
In-Reply-To: <20231002184136.GA1539@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HAS2VO5y3up6UKra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 02, 2023 at 08:41:36PM +0200, Peter Zijlstra wrote:

> When mixing request sizes things become a little more interesting.
> 
> Let me ponder this a little bit more.

Using the attached program (I got *REALLY* fed up trying to draw these
diagrams by hand), let us illustrate the difference between Earliest
*Eligible* Virtual Deadline First and the one with the Eligible test
taken out: EVDF.

Specifically, the program was used with the following argument for
EEVDF:

  ./eevdf -e "0,1024,6" -e "1,1024,2" -e "2,1024,18" -v 19 

and with an additional '-n' for the EVDF column.


EEVDF							EVDF


d = 6							d = 6
d = 2                                                   d = 2
d = 18                                                  d = 18
q = 2                                                   q = 2
                                                        
t=0 V=1                                                 t=0 V=1
 A |----<                                                A |----<
>B  |<                                                  >B  |<
 C   |----------------<                                  C   |----------------<
   |*--------|---------|---------|---------|----           |*--------|---------|---------|---------|----
                                                        
                                                        
t=2 V=1                                                 t=2 V=1
>A |----<                                                A |----<
 B    |<                                                >B    |<
 C   |----------------<                                  C   |----------------<
   |*--------|---------|---------|---------|----           |*--------|---------|---------|---------|----
                                                        
                                                        
t=8 V=3                                                 t=4 V=2
 A       |----<                                         >A |----<
>B    |<                                                 B      |<
 C   |----------------<                                  C   |----------------<
   |--*------|---------|---------|---------|----           |-*-------|---------|---------|---------|----
                                                        
                                                        
t=10 V=4                                                t=10 V=4
 A       |----<                                          A       |----<
 B      |<                                              >B      |<
>C   |----------------<                                  C   |----------------<
   |---*-----|---------|---------|---------|----           |---*-----|---------|---------|---------|----
                                                        
                                                        
t=28 V=10                                               t=12 V=5
 A       |----<                                          A       |----<
>B      |<                                              >B        |<
 C                     |----------------<                C   |----------------<
   |---------*---------|---------|---------|----           |----*----|---------|---------|---------|----
                                                        
                                                        
t=30 V=11                                               t=14 V=5
 A       |----<                                          A       |----<
>B        |<                                            >B          |<
 C                     |----------------<                C   |----------------<
   |---------|*--------|---------|---------|----           |----*----|---------|---------|---------|----
                                                        
                                                        
t=32 V=11                                               t=16 V=6
 A       |----<                                         >A       |----<
>B          |<                                           B            |<
 C                     |----------------<                C   |----------------<
   |---------|*--------|---------|---------|----           |-----*---|---------|---------|---------|----
                                                        
                                                        
t=34 V=12                                               t=22 V=8
>A       |----<                                          A             |----<
 B            |<                                        >B            |<
 C                     |----------------<                C   |----------------<
   |---------|-*-------|---------|---------|----           |-------*-|---------|---------|---------|----
                                                        
                                                        
t=40 V=14                                               t=24 V=9
 A             |----<                                    A             |----<
>B            |<                                        >B              |<
 C                     |----------------<                C   |----------------<
   |---------|---*-----|---------|---------|----           |--------*|---------|---------|---------|----
                                                        
                                                        
t=42 V=15                                               t=26 V=9
 A             |----<                                    A             |----<
>B              |<                                      >B                |<
 C                     |----------------<                C   |----------------<
   |---------|----*----|---------|---------|----           |--------*|---------|---------|---------|----
                                                        
                                                        
t=44 V=15                                               t=28 V=10
 A             |----<                                   >A             |----<
>B                |<                                     B                  |<
 C                     |----------------<                C   |----------------<
   |---------|----*----|---------|---------|----           |---------*---------|---------|---------|----
                                                        
                                                        
t=46 V=16                                               t=34 V=12
>A             |----<                                    A                   |----<
 B                  |<                                  >B                  |<
 C                     |----------------<                C   |----------------<
   |---------|-----*---|---------|---------|----           |---------|-*-------|---------|---------|----
                                                        
                                                        
t=52 V=18                                               t=36 V=13
 A                   |----<                              A                   |----<
>B                  |<                                   B                    |<
 C                     |----------------<               >C   |----------------<
   |---------|-------*-|---------|---------|----           |---------|--*------|---------|---------|----
                                                        
                                                        
t=54 V=19                                               t=54 V=19
 A                   |----<                              A                   |----<
>B                    |<                                >B                    |<
 C                     |----------------<                C                     |----------------<
   |---------|--------*|---------|---------|----           |---------|--------*|---------|---------|----
                                                        
                                                        
lags: -10, 6                                            lags: -7, 11
                                                        
BAaaBCccccccccBBBAaaBBBAaaBB                            BBAaaBBBAaaBBBAaaBCccccccccB



As I wrote before; EVDF has worse lag bounds, but this is not
insurmountable. The biggest problem that I can see is that of wakeup
preemption. Currently we allow to preempt when 'current' has reached V
(RUN_TO_PARITY in pick_eevdf()).

With these rules, when EEVDF schedules C (our large slice task) at t=10
above, it is only a little behind C and can be reaily preempted after
about 2 time units.

However, EVDF will delay scheduling C until much later, see how A and B
walk far ahead of V until t=36. Only when will we pick C. But this means
that we're firmly stuck with C for at least 11 time units. A newly
placed task will be around V and will have no chance to preempt.

That said, I do have me a patch to cure some of that:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/eevdf&id=d7edbe431f31762e516f2730196f41322edcc621

That would allow a task with a shorter request time to preempt in spite
of RUN_TO_PARITY.

However, in this example V is only 2/3 of the way to C's deadline, but
it we were to have many more tasks, you'll see V gets closer and closer
to C's deadline and it will become harder and harder to place such that
preemption becomes viable.

Adding 4 more tasks:

  ./eevdf -e "0,1024,6" -e "1,1024,2" -e "2,1024,18" -v 19 -n -e "3,1024,2" -e "4,1024,2" -e "5,1024,2" -e "6,1024,2"

t=92 V=16
 A                   |----<
 B                    |<
>C   |----------------<
 D                    |<
 E                   |<
 F                    |<
 G                   |<
   |---------|-----*---|---------|---------|----


And I worry this will create very real latency spikes.

That said; I do see not having the eligibility check can help. So I'm
not opposed to having a sched_feat for this, but I would not want to
default to EVDF.

--HAS2VO5y3up6UKra
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="eevdf.c"

/* GPL-2.0 */
#include <stdio.h>
#include <limits.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdbool.h>
#include <sys/param.h>

bool eligible = true;
unsigned long V_lim = 20;

struct entity {
	unsigned long vruntime;
	unsigned long weight;
	unsigned long request;
	unsigned long vdeadline;
	int idx;
};

unsigned int gcd(unsigned int a, unsigned int b)
{
	int gcd, m = MIN(a, b);

	for (int i = 1; i <= m; i++) {
		if (a%i == 0 && b%i == 0)
			gcd = i;
	}

	return gcd;
}

int init_entities(int nr, struct entity *es)
{
	unsigned int q = 0;

	for (int i = 0; i < nr; i++) {
		unsigned long d = (1024 * es[i].request) / es[i].weight;
		printf("d = %d\n", d);
		if (!q)
			q = d;
		else
			q = gcd(q, d);

		es[i].vdeadline = es[i].vruntime + d;
		es[i].idx = i;
	}

	printf("q = %d\n\n", q);

	return q;
}

int run_entity(struct entity *e)
{
	unsigned long d = e->vdeadline - e->vruntime;

	d *= e->weight;
	d /= 1024;

	e->vruntime = e->vdeadline;
	e->vdeadline += (1024 * e->request) / e->weight;

	return d;
}

unsigned long avg_vruntime(int nr, struct entity *es)
{
	unsigned long W = 0, V = 0;

	for (int i = 0; i < nr; i++) {
		V += es[i].weight * es[i].vruntime;
		W += es[i].weight;
	}

	V /= W;

	return V;
}

struct entity *pick_entity(int nr, struct entity *es)
{
	unsigned long W = 0, V = 0;
	struct entity *e = NULL;

	for (int i = 0; i < nr; i++) {
		V += es[i].weight * es[i].vruntime;
		W += es[i].weight;
	}

	for (int i = 0; i < nr; i++) {
		if (eligible && W*es[i].vruntime > V)
			continue;

		if (!e || es[i].vdeadline < e->vdeadline)
			e = &es[i];
	}

	return e;
}

void __print_space(int n)
{
	for (int i = 0; i < n; i++)
		putchar(' ');
}

void __print_arrow(int n)
{
	putchar('|');
	for (int i = 1; i < (n-1); i++)
		putchar('-');
	putchar('<');
}

void print_entity(struct entity *e)
{
	__print_space(e->vruntime);
	__print_arrow(e->vdeadline - e->vruntime);
}

void print_entities(int nr, struct entity *es, struct entity *p)
{
	for (int i = 0; i < nr; i++) {
		if (&es[i] == p)
			putchar('>');
		else
			putchar(' ');
		putchar('A' + i);
		putchar(' ');
		print_entity(&es[i]);
		putchar('\n');
	}
}

void print_timeline(unsigned long V)
{
	char timeline[] = "|---------|---------|---------|---------|----";

	if (V > sizeof(timeline)-1) {
		printf("Whoopsie! out of time\n");
		exit(0);
	}

	timeline[V] = '*';
	__print_space(3);
	puts(timeline);
	putchar('\n');
}

void update_lags(int nr, struct entity *es, unsigned long V, long *min, long *max)
{
	for (int i = 0; i < nr; i++) {
		long lag = V - es[i].vruntime;
		if (lag < *min)
			*min = lag;
		if (lag > *max)
			*max = lag;
	}
}

int main(int argc, char *argv[])
{
	unsigned int s = 0, t = 0, n = 0, q = 1;
	long min_lag = 0, max_lag = 0;
	struct entity *e, es[8];
	unsigned long V;
	char S[1024];
	int opt;

	const int N = sizeof(es) / sizeof(es[0]);

	while ((opt = getopt(argc, argv, "nv:e:")) != -1) {
		unsigned int v,w,r;

		switch (opt) {
		case 'n':
			eligible = false;
			break;

		case 'v':
			V_lim = atol(optarg);
			break;

		case 'e':
			if (n >= N) {
				printf("Whoopsie! too many entities\n");
				exit(0);
			}
			if (sscanf(optarg, "%u,%u,%u", &v,&w,&r) == 3) {
				es[n++] = (struct entity) {
					.vruntime = v,
					.weight = w,
					.request = r,
				};
			}
			break;

		default:
			printf("Whoopsie!, bad arguments\n");
			exit(0);
		}
	}

	if (!n) {
		printf("Whoopsie!, no entities\n");
		exit(0);
	}

	q = init_entities(n, es);

	do {
		int d;

		V = avg_vruntime(n, es);
		printf("t=%d V=%ld\n", t, V);

		update_lags(n, es, V, &min_lag, &max_lag);

		e = pick_entity(n, es);
		if (!e) {
			printf("Whoopsie, no pick\n");
			exit(0);
		}

		print_entities(n, es, e);
		print_timeline(V);

		d = run_entity(e);
		t += d;

		for (int i = 0; i < d; i += q) {
			char c = 'A' + e->idx;
			if (i)
				c = 'a' + e->idx;
			S[s++] = c;
			S[s] = '\0';
		}

		putchar('\n');
	} while (V < V_lim);

	printf("lags: %ld, %ld\n\n", min_lag, max_lag);

	puts(S);
	putchar('\n');

	return 0;
}

--HAS2VO5y3up6UKra--
